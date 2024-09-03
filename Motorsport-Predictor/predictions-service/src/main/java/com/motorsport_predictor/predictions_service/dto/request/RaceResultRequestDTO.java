package com.motorsport_predictor.predictions_service.dto.request;

import com.motorsport_predictor.predictions_service.dto.RaceResultDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RaceResultRequestDTO {
    private List<RaceResultDTO> raceResult;
}