package com.motorsport_predictor.predictions_service.services.impl;

import com.motorsport_predictor.predictions_service.dto.PredictionDTO;
import com.motorsport_predictor.predictions_service.dto.PredictionNotificationDTO;
import com.motorsport_predictor.predictions_service.dto.RaceDTO;
import com.motorsport_predictor.predictions_service.dto.request.PredictionsRequestDTO;
import com.motorsport_predictor.predictions_service.dto.request.RaceResultRequestDTO;
import com.motorsport_predictor.predictions_service.exceptions.BadRequestException;
import com.motorsport_predictor.predictions_service.feign.IF1Client;
import com.motorsport_predictor.predictions_service.feign.IUserClient;
import com.motorsport_predictor.predictions_service.models.entities.F1Prediction;
import com.motorsport_predictor.predictions_service.models.repositories.IF1PredictionRepository;
import com.motorsport_predictor.predictions_service.services.IF1PredictionService;
import com.motorsport_predictor.predictions_service.utils.JsonUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class F1PredictionServiceImpl implements IF1PredictionService {
    private final IUserClient usersClient;
    private final IF1Client f1Client;
    private final IF1PredictionRepository f1PredictionRepository;
    private final KafkaProducer kafkaProducer;

    @Override
    public void createPrediction(
            @PathVariable Long memberGroupId,
            @PathVariable Long raceId,
            PredictionsRequestDTO request) {

        // Check if user exist in the group
        String userId = usersClient.getLoggedInUserId();
        if (!usersClient.existUserInGroup(memberGroupId, userId)) {
            throw new BadRequestException("El usuario no pertenece al grupo.");
        }

        // Check if race_id exist
        boolean raceExists = f1Client.existsRacesById(raceId);
        if (!raceExists) {
            throw new IllegalArgumentException("La carrera no existe.");
        }

        // Count how many predictions already exist for the user in this race
        int existingPredictions = f1PredictionRepository.countByGroupMemberIdAndRaceId(memberGroupId, raceId);
        if (existingPredictions >= 10) {
            throw new IllegalArgumentException("El usuario ya ha realizado 10 predicciones para esta carrera.");
        }

        // Validate number of predictions
        if (request.getPredictions().size() > 10) {
            throw new IllegalArgumentException("Solo se permiten hasta 10 predicciones por solicitud.");
        }

        // Check if driver exists
        request.getPredictions().forEach(prediction -> {
            boolean driverExists = f1Client.existsById(prediction.getDriverId());
            if (!driverExists) {
                throw new IllegalArgumentException("El piloto con ID " + prediction.getDriverId() + " no existe.");
            }
        });

        // Check for duplicate drivers
        Set<Long> driverIds = new HashSet<>();
        for (PredictionDTO prediction : request.getPredictions()) {
            if (!driverIds.add(prediction.getDriverId())) {
                throw new IllegalArgumentException("No se pueden repetir pilotos en una predicción.");
            }
        }

        // Check for duplicate positions
        Set<Integer> positions = new HashSet<>();
        for (PredictionDTO prediction : request.getPredictions()) {
            if (!positions.add(prediction.getPredictedPosition())) {
                throw new IllegalArgumentException("No se pueden repetir los puestos.");
            }
        }

        // Save each prediction
        List<PredictionDTO> savedPredictions = new ArrayList<>();
        for (PredictionDTO predictionDto : request.getPredictions()) {
            F1Prediction individualPrediction = new F1Prediction();
            individualPrediction.setGroupMemberId(memberGroupId);
            individualPrediction.setRaceId(raceId);
            individualPrediction.setDriverId(predictionDto.getDriverId());
            individualPrediction.setPredictedPosition(predictionDto.getPredictedPosition());
            individualPrediction.setCreatedAt(LocalDateTime.now());
            f1PredictionRepository.save(individualPrediction);
            savedPredictions.add(predictionDto);
        }

        String userEmail = usersClient.getUserEmail();

        // Create DTO to send to kafka
        RaceDTO raceInfo = f1Client.getRaceInfo(raceId);
        raceInfo.setEmail(userEmail);

        // Send to kafka
        kafkaProducer.sendPredictionNotification(JsonUtils.toJson(raceInfo));
    }

    @Override
    public String getUserEmail() {
        return usersClient.getUserEmail();
    }
}
