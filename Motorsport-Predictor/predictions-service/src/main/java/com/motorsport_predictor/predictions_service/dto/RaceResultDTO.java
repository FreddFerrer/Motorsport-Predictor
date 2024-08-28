package com.motorsport_predictor.predictions_service.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class RaceResultDTO {
    @NotNull(message = "El ID del piloto no puede ser nulo")
    private Long driverId;

    @Min(value = 1, message = "La posición no puede ser menor que 1")
    @Max(value = 10, message = "La posición no puede ser mayor que 10")
    private int position;
}
