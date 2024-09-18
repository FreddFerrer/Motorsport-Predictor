package com.motorsport_predictor.predictions_service.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class PredictionDTO {
    private Long driverId;
    private Integer predictedPosition;
}
