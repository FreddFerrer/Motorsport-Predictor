package com.motorsport_predictor.gateway_server.service;


import com.motorsport_predictor.gateway_server.dto.request.LoginRequestDTO;

import java.util.Map;

public interface IUserService {

    Map<String, Object> login(LoginRequestDTO loginRequestDTO);
}