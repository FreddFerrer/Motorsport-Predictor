package com.motorsport_predictor.f1_service.dto;

import lombok.Data;

import java.util.List;

@Data
public class RaceResultIdDTO {
    private List<Long> driverIds;
}
