package com.motorsport_predictor.predictions_service.services.impl;

import com.motorsport_predictor.predictions_service.dto.PredictionDTO;
import com.motorsport_predictor.predictions_service.dto.RaceResultDTO;
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
import java.util.List;
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

        // Contar cuántas predicciones ya existen para el usuario en esta carrera
        int existingPredictions = f1PredictionRepository.countByGroupMemberIdAndRaceId(memberGroupId, raceId);
        if (existingPredictions >= 10) {
            throw new IllegalArgumentException("El usuario ya ha realizado 10 predicciones para esta carrera.");
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

        // Validar pilotos duplicados
        Set<Long> driverIds = new HashSet<>();
        for (PredictionDTO prediction : request.getPredictions()) {
            if (!driverIds.add(prediction.getDriverId())) {
                throw new IllegalArgumentException("No se pueden repetir pilotos en una predicción.");
            }
        }

        // Validar puestos duplicados
        Set<Integer> positions = new HashSet<>();
        for (PredictionDTO prediction : request.getPredictions()) {
            if (!positions.add(prediction.getPredictedPosition())) {
                throw new IllegalArgumentException("No se pueden repetir los puestos.");
            }
        }

        // Guardar las predicciónes
        // Iterar sobre las predicciones individuales y guardarlas
        for (PredictionDTO predictionDto : request.getPredictions()) {
            F1Prediction individualPrediction = new F1Prediction();
            individualPrediction.setGroupMemberId(memberGroupId);
            individualPrediction.setRaceId(raceId);
            individualPrediction.setDriver(predictionDto.getDriverId());
            individualPrediction.setPredictedPosition(predictionDto.getPredictedPosition());
            individualPrediction.setCreatedAt(LocalDateTime.now());
            f1PredictionRepository.save(individualPrediction);
        }

    }

    @Override
    public void updateF1RaceResults(Long raceId, List<RaceResultDTO> results) {
        for (RaceResultDTO result : results) {
            f1PredictionRepository.updateActualPosition(result.getPosition(), raceId, result.getDriverId());
        }
    }
}
