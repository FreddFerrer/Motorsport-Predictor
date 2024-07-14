package com.fredd.motorsport_predictor.service;

import com.fredd.motorsport_predictor.dto.response.UserDto;
import com.fredd.motorsport_predictor.dto.request.LoginRequestDto;
import com.fredd.motorsport_predictor.dto.request.SignUpRequestDto;

public interface IAuthService {
    UserDto signup(SignUpRequestDto request);
}
