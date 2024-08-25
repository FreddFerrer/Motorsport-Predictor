package com.motorsport_predictor.predictions_service.services;

import com.motorsport_predictor.predictions_service.dto.request.PredictionsRequestDTO;
import com.motorsport_predictor.predictions_service.dto.request.ResultRequestDTO;

import java.util.List;

public interface IF1PredictionService {
    void createPrediction(Long groupMemberId, Long raceId, PredictionsRequestDTO request);

    void uploadF1RaceResults(Long raceId, List<ResultRequestDTO> results);
}
