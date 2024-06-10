package com.fredd.motorsport_predictor.service.impl;

import com.fredd.motorsport_predictor.dto.response.UserDto;
import com.fredd.motorsport_predictor.dto.request.SignUpRequestDto;
import com.fredd.motorsport_predictor.models.entities.User;
import com.fredd.motorsport_predictor.models.mappers.IUserDtoMapper;
import com.fredd.motorsport_predictor.repositories.IUserRepository;
import com.fredd.motorsport_predictor.service.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements IUserService {

    private final IUserRepository userRepository;
    private final IUserDtoMapper userDtoMapper;

    @Override
    public List<UserDto> getAllUsers() {
        List<User> allUsers = userRepository.findAll();

        return allUsers.stream()
                .map(userDtoMapper::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<UserDto> getUserById(Long id) {
        return userRepository.findById(id).map(userDtoMapper::toDto);
    }

    @Override
    public Optional<UserDto> getUserByEmailOrUsername() {
        return Optional.empty();
    }

    @Override
    public UserDto saveUser(SignUpRequestDto userRequest) {
        User newUser = userDtoMapper.toEntity(userRequest);
        userRepository.save(newUser);
        return userDtoMapper.toDto(newUser);
    }

    //To be completed
    @Override
    public UserDto editUser() {
        return null;
    }

    //To be completed
    @Override
    public void deleteUser() {

    }
}
