package com.motorsport_predictor.f1_service.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RaceResultRequestDTO {
    @NotNull(message = "La lista de resultados no puede ser nula")
    private List<String> driverShortnames;
}
