package com.motorsport_predictor.predictions_service.services;

import com.motorsport_predictor.predictions_service.dto.RaceResultDTO;
import com.motorsport_predictor.predictions_service.dto.request.PredictionsRequestDTO;

import java.util.List;


public interface IF1PredictionService {
    void createPrediction(Long groupMemberId, Long raceId, PredictionsRequestDTO request);

    void updateF1RaceResults(Long raceId, List<RaceResultDTO> results);
}
