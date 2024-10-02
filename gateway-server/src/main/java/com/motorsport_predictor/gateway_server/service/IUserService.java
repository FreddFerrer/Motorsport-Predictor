package com.motorsport_predictor.gateway_server.service;


import com.motorsport_predictor.gateway_server.dto.request.CreateUserDTO;
import com.motorsport_predictor.gateway_server.dto.request.LoginRequestDTO;
import lombok.NonNull;
import org.keycloak.representations.idm.UserRepresentation;

import java.util.Map;

public interface IUserService {
    Map<String, Object> login(LoginRequestDTO loginRequestDTO);
    UserRepresentation createUser(@NonNull CreateUserDTO userDTO);
}