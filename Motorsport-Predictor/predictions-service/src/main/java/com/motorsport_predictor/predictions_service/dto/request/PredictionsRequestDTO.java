package com.motorsport_predictor.predictions_service.dto.request;

import com.motorsport_predictor.predictions_service.dto.PredictionDTO;
import lombok.*;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PredictionsRequestDTO {
    private List<PredictionDTO> predictions;
}
