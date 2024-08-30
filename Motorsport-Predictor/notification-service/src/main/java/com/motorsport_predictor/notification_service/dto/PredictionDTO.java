package com.motorsport_predictor.notification_service.dto;

import lombok.Data;

@Data
public class PredictionDTO {
    private Long driverId;
    private Integer predictedPosition;
}
