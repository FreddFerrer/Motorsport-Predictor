package com.motorsport_predictor.notification_service.dto;

import lombok.Data;

import java.util.List;

@Data
public class PredictionNotificationDTO {
    private String email;
    private List<PredictionDTO> predictions;
}