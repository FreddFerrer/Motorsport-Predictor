package com.motorsport_predictor.predictions_service.dto.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RaceResultRequestDTO {
    private List<String> driverShortnames;
}