package com.motorsport_predictor.predictions_service.services.impl;

import com.motorsport_predictor.predictions_service.dto.request.PredictionsRequestDTO;
import com.motorsport_predictor.predictions_service.exceptions.BadRequestException;
import com.motorsport_predictor.predictions_service.feign.IF1Client;
import com.motorsport_predictor.predictions_service.feign.IUserClient;
import com.motorsport_predictor.predictions_service.services.IF1PredictionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

@Service
@RequiredArgsConstructor
public class F1PredictionServiceImpl implements IF1PredictionService {

    private final IUserClient usersClient;
    private final IF1Client f1Client;

    @Override
    public void createPrediction(
            @PathVariable Long memberGroupId,
            @PathVariable Long raceId,
            PredictionsRequestDTO request) {

        // Consulta el id del usuario logeado
        String userIdFromService = usersClient.getLoggedInUserId();

        // Verificar si el usuario pertenece al grupo
        String userId = usersClient.getLoggedInUserId();
        if (!usersClient.existUserInGroup(memberGroupId, userId)) {
            throw new BadRequestException("El usuario no pertenece al grupo.");
        }

        // Verificar si existe race_id

        // Validar cantidad de predicciones
        if (request.getPredictions().size() > 10) {
            throw new IllegalArgumentException("Solo se permiten hasta 10 predicciones por solicitud.");
        }

        // Validar existencia de grupo, carrera y pilotos
        //f1Client.getGroupId(groupId);
        //f1Client.getRaceId(raceId);
        //request.getPredictions().forEach(prediction -> {
        //    f1Client.validateDriverId(prediction.getDriverId());
        //});

        // Validar duplicados (aquí puedes implementar una consulta a la base de datos para verificar si ya existe una predicción para ese usuario, grupo, carrera y piloto)
        //boolean hasDuplicates = predictionRepository.existsByGroupIdAndRaceIdAndUserIdAndDriverId(groupId, raceId, userId, prediction.getDriverId());
        //if (hasDuplicates) {
        //    throw new IllegalArgumentException("Ya existe una predicción para este piloto.");
        //}


    }
}
