package com.motorsport_predictor.f1_service.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DriverDTO {
    private String name;
    private String nationality;
    private TeamDTO team;
}
