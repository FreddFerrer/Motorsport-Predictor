package com.fredd.motorsport_predictor.service;

import com.fredd.motorsport_predictor.dto.response.UserDto;
import com.fredd.motorsport_predictor.dto.request.SignUpRequestDto;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

public interface IUserService {
    List<UserDto> getAllUsers();
    Optional<UserDto> getUserById(Long id);
    Optional<UserDto> getUserByEmailOrUsername();
    UserDto saveUser(SignUpRequestDto userRequest);
    UserDto editUser();
    void deleteUser();
}
