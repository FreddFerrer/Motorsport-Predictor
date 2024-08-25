package com.motorsport_predictor.predictions_service.dto.request;

import lombok.Data;

@Data
public class ResultRequestDTO {
    private Long driverId;
    private int position;
}
