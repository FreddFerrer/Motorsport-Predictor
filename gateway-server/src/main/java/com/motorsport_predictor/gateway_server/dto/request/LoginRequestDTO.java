package com.motorsport_predictor.gateway_server.dto.request;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LoginRequestDTO {

    @Schema(example = "usuario_prueba_1")
    @NotEmpty(message = "Required field")
    @NotNull
    private String username;

    @Schema(example = "Password@123")
    @NotEmpty(message = "Required field")
    @NotNull
    private String password;
}