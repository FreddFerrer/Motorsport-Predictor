package com.fredd.motorsport_predictor.service;

import com.fredd.motorsport_predictor.dto.UserDto;
import com.fredd.motorsport_predictor.dto.request.UserRequestDto;
import com.fredd.motorsport_predictor.models.entities.User;

import java.util.List;
import java.util.Optional;

public interface IUserService {
    List<UserDto> getAllUsers();
    Optional<UserDto> getUserById(Long id);
    Optional<UserDto> getUserByEmailOrUsername();
    UserDto saveUser(UserRequestDto userRequest);
    UserDto editUser();
    void deleteUser();
}
