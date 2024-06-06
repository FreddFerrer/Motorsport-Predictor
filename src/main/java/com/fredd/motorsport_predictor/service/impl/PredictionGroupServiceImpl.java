package com.fredd.motorsport_predictor.service.impl;

import com.fredd.motorsport_predictor.dto.PredictionGroupDto;
import com.fredd.motorsport_predictor.models.entities.PredictionGroup;
import com.fredd.motorsport_predictor.service.IPredictionGroupService;

import java.util.List;
import java.util.Optional;

public class PredictionGroupServiceImpl implements IPredictionGroupService {
    @Override
    public List<PredictionGroup> getAllPredictionGroup() {
        return null;
    }

    @Override
    public Optional<PredictionGroup> getPredictionGroupById(Long id) {
        return Optional.empty();
    }

    @Override
    public Optional<PredictionGroup> getPredictionGroupByUser() {
        return Optional.empty();
    }

    @Override
    public PredictionGroupDto newPredictionGroup() {
        return null;
    }

    @Override
    public PredictionGroupDto editPredictionGroup() {
        return null;
    }

    @Override
    public void deletePredictionGroup() {

    }
}
