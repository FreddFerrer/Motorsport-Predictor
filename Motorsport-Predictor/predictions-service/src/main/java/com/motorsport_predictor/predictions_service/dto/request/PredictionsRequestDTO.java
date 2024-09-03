package com.motorsport_predictor.predictions_service.dto.request;

import com.motorsport_predictor.predictions_service.dto.PredictionDTO;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class PredictionsRequestDTO {
    private List<PredictionDTO> predictions;
}
