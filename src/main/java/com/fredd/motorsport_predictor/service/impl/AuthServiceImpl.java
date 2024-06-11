package com.fredd.motorsport_predictor.service.impl;

import com.fredd.motorsport_predictor.dto.response.UserDto;
import com.fredd.motorsport_predictor.dto.request.LoginRequestDto;
import com.fredd.motorsport_predictor.dto.request.SignUpRequestDto;
import com.fredd.motorsport_predictor.enums.UserRole;
import com.fredd.motorsport_predictor.exceptions.BadRequestException;
import com.fredd.motorsport_predictor.jwt.JwtService;
import com.fredd.motorsport_predictor.models.entities.User;
import com.fredd.motorsport_predictor.models.mappers.IUserDtoMapper;
import com.fredd.motorsport_predictor.repositories.IUserRepository;
import com.fredd.motorsport_predictor.service.IAuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements IAuthService {
    private final IUserRepository userRepository;
    private final JwtService jwtService;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final IUserDtoMapper userDtoMapper;


    @Override
    public UserDto login(LoginRequestDto request) {
        var authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(request.getUsernameOrEmail(), request.getPassword()));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        User user= userRepository.findByUsername(request.getUsernameOrEmail()).orElse(null);

        if (user == null) {
            user = userRepository.findByUserEmail(request.getUsernameOrEmail()).orElse(null);
        }
        if (user == null) {
            throw new BadRequestException("Invalid username or email");
        }

        String token=jwtService.getToken(user);
        UserDto userDto = userDtoMapper.toDto(user);
        userDto.setToken(token);
        return userDto;

    }

    @Override
    public UserDto signup(SignUpRequestDto request) {
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new BadRequestException("Username already exists");
        }

        if (userRepository.existsByUserEmail(request.getUserEmail())) {
            throw new BadRequestException("Email already exists");
        }

        User user = userDtoMapper.toEntity(request);

        UserRole role = UserRole.USER;

        String encodedPassword = passwordEncoder.encode(request.getUserPassword());

        user.setUserPassword(encodedPassword);
        user.setUserRole(role);

        userRepository.save(user);

        return userDtoMapper.toDto(user);
    }
}
