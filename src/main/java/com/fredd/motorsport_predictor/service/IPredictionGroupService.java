package com.fredd.motorsport_predictor.service;

import com.fredd.motorsport_predictor.dto.PredictionGroupDto;
import com.fredd.motorsport_predictor.models.entities.PredictionGroup;

import java.util.List;
import java.util.Optional;

public interface IPredictionGroupService {
    List<PredictionGroup> getAllPredictionGroup();
    Optional<PredictionGroup> getPredictionGroupById(Long id);
    Optional<PredictionGroup> getPredictionGroupByUser();   //devuelve todos los grupos creados por un usuario
    PredictionGroupDto newPredictionGroup();
    PredictionGroupDto editPredictionGroup();
    void deletePredictionGroup();
}
