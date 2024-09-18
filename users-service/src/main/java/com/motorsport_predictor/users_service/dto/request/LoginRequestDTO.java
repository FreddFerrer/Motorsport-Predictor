package com.motorsport_predictor.users_service.dto.request;

import lombok.Data;

@Data
public class LoginRequestDTO {
    private String username;
    private String password;
}
