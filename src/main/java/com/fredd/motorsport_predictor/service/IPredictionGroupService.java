package com.fredd.motorsport_predictor.service;

import com.fredd.motorsport_predictor.dto.response.PredictionGroupDto;
import com.fredd.motorsport_predictor.dto.request.PredictionGroupRequestDto;

import java.util.List;
import java.util.Optional;

public interface IPredictionGroupService {

    List<PredictionGroupDto> getAllPredictionGroup();

    Optional<PredictionGroupDto> getPredictionGroupById(Long id);

    Optional<PredictionGroupDto> getPredictionGroupByUser(String userCreator);   //devuelve todos los grupos creados por un usuario

    PredictionGroupDto savePredictionGroup(PredictionGroupRequestDto predictionGroupRequestDto);

    PredictionGroupDto editPredictionGroup(PredictionGroupRequestDto predictionGroupRequestDto);

    void deletePredictionGroup(Long id);
}
