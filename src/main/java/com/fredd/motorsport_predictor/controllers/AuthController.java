package com.fredd.motorsport_predictor.controllers;

import com.fredd.motorsport_predictor.dto.request.LoginRequestDto;
import com.fredd.motorsport_predictor.dto.request.SignUpRequestDto;
import com.fredd.motorsport_predictor.dto.response.UserDto;
import com.fredd.motorsport_predictor.exceptions.BadRequestException;
import com.fredd.motorsport_predictor.service.IAuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {
    private final IAuthService authService;

    public ResponseEntity<UserDto> login(@RequestBody @Valid LoginRequestDto request)
    {
        try {
            return ResponseEntity.ok(authService.login(request));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    public ResponseEntity<UserDto> register(@RequestBody @Valid SignUpRequestDto request)
    {
        try {
            return ResponseEntity.ok(authService.signup(request));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }
}
