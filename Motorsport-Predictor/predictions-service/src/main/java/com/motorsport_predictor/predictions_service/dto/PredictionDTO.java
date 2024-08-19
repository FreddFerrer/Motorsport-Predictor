package com.motorsport_predictor.predictions_service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PredictionDTO {
    private Long driverId;
    private Integer predictedPosition;
}
