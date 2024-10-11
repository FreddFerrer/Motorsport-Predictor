package com.motorsport_predictor.f1_service.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
public class RaceResultRequestDTO {
    @NotNull(message = "La lista de resultados no puede ser nula")
    private List<String> driverShortnames;
}
