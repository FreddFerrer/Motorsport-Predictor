package com.motorsport_predictor.predictions_service.services.impl;

import com.motorsport_predictor.predictions_service.dto.PredictionDTO;
import com.motorsport_predictor.predictions_service.dto.request.PredictionsRequestDTO;
import com.motorsport_predictor.predictions_service.exceptions.BadRequestException;
import com.motorsport_predictor.predictions_service.feign.IF1Client;
import com.motorsport_predictor.predictions_service.feign.IUserClient;
import com.motorsport_predictor.predictions_service.models.entities.F1Prediction;
import com.motorsport_predictor.predictions_service.models.repositories.IF1PredictionRepository;
import com.motorsport_predictor.predictions_service.services.IF1PredictionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class F1PredictionServiceImpl implements IF1PredictionService {

    private final IUserClient usersClient;
    private final IF1Client f1Client;
    private final IF1PredictionRepository f1PredictionRepository;

    @Override
    public void createPrediction(
            @PathVariable Long memberGroupId,
            @PathVariable Long raceId,
            PredictionsRequestDTO request) {

        // Verificar si el usuario pertenece al grupo
        String userId = usersClient.getLoggedInUserId();
        if (!usersClient.existUserInGroup(memberGroupId, userId)) {
            throw new BadRequestException("El usuario no pertenece al grupo.");
        }

        // Verificar si existe race_id
        boolean raceExists = f1Client.existsRacesById(raceId);
        if (!raceExists) {
            throw new IllegalArgumentException("La carrera no existe.");
        }

        // Validar cantidad de predicciones
        if (request.getPredictions().size() > 10) {
            throw new IllegalArgumentException("Solo se permiten hasta 10 predicciones por solicitud.");
        }

        // Verificar si existe el piloto
        request.getPredictions().forEach(prediction -> {
            boolean driverExists = f1Client.existsById(prediction.getDriverId());
            if (!driverExists) {
                throw new IllegalArgumentException("El piloto con ID " + prediction.getDriverId() + " no existe.");
            }
        });

        // Validar duplicados
        Set<Long> driverIds = new HashSet<>();
        for (PredictionDTO prediction : request.getPredictions()) {
            if (!driverIds.add(prediction.getDriverId())) {
                throw new IllegalArgumentException("No se pueden repetir pilotos en una predicción.");
            }
        }

        // Guardar las predicciónes
        // Iterar sobre las predicciones individuales y guardarlas
        for (PredictionDTO predictionDto : request.getPredictions()) {
            F1Prediction individualPrediction = new F1Prediction();
            individualPrediction.setGroupMemberId(memberGroupId);
            individualPrediction.setRace(raceId);
            individualPrediction.setDriver(predictionDto.getDriverId());
            individualPrediction.setPredictedPosition(predictionDto.getPredictedPosition());
            individualPrediction.setCreatedAt(LocalDateTime.now());
            f1PredictionRepository.save(individualPrediction);
        }

    }
}