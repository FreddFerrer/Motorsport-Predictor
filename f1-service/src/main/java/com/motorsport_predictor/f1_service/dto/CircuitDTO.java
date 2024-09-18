package com.motorsport_predictor.f1_service.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CircuitDTO {
    private String circuitName;
    private String locality;
    private String country;
}
