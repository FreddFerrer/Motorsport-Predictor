package com.fredd.motorsport_predictor.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginRequestDto {
    @NotNull(message = "Required field")
    private String usernameOrEmail;

    @NotNull(message = "Required field")
    private String password;
}
