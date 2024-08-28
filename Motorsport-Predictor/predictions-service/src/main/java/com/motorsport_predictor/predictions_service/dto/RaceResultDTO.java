package com.motorsport_predictor.predictions_service.dto;

import lombok.Data;

@Data
public class RaceResultDTO {
    private Long raceId;
    private Long driverId;
    private int position;
}
