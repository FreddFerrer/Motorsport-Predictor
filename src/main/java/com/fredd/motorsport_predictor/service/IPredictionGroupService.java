package com.fredd.motorsport_predictor.service;

import com.fredd.motorsport_predictor.dto.PredictionGroupDto;
import com.fredd.motorsport_predictor.dto.request.PredictionGroupRequestDto;
import com.fredd.motorsport_predictor.models.entities.PredictionGroup;
import com.fredd.motorsport_predictor.models.entities.User;

import java.util.List;
import java.util.Optional;

public interface IPredictionGroupService {

    List<PredictionGroupDto> getAllPredictionGroup();

    Optional<PredictionGroupDto> getPredictionGroupById(Long id);

    Optional<PredictionGroupDto> getPredictionGroupByUser(User userCreator);   //devuelve todos los grupos creados por un usuario

    PredictionGroupDto savePredictionGroup(PredictionGroupRequestDto predictionGroupRequestDto);

    Optional<PredictionGroupDto> editPredictionGroup(PredictionGroupRequestDto predictionGroupRequestDto);

    Boolean deletePredictionGroup(Long id);
}
