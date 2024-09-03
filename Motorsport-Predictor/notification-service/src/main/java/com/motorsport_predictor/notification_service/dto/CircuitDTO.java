package com.motorsport_predictor.notification_service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CircuitDTO {
    private String circuitName;
    private String locality;
    private String country;
}