package com.fredd.motorsport_predictor.controllers;

import com.fredd.motorsport_predictor.dto.request.SignUpRequestDto;
import com.fredd.motorsport_predictor.dto.response.UserDto;
import com.fredd.motorsport_predictor.exceptions.BadRequestException;
import com.fredd.motorsport_predictor.service.IAuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {
    private final IAuthService authService;


    @PostMapping("/signup")
    public ResponseEntity<UserDto> register(@RequestBody @Valid SignUpRequestDto request)
    {
        try {
            return ResponseEntity.ok(authService.signup(request));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/user")
    public ResponseEntity<String> read_user (Authentication authentication)
    {
        return ResponseEntity.ok("The user can read." + authentication.getName() +  authentication.getAuthorities() );
    }

    @PostMapping("/user")
    public ResponseEntity<String> write_user (Authentication authentication)
    {
        return ResponseEntity.ok("The user can write." +authentication.getAuthorities() );
    }
}
