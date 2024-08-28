package com.motorsport_predictor.f1_service.dto.request;

import com.motorsport_predictor.f1_service.dto.RaceResultDTO;
import lombok.Data;

import java.util.List;

@Data
public class RaceResultRequestDTO {
    private List<RaceResultDTO> raceResult;
}
