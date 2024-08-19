package com.motorsport_predictor.users_service.service;

import com.motorsport_predictor.users_service.dto.request.CreateUserDTO;
import org.keycloak.representations.idm.UserRepresentation;

import java.util.List;

public interface IUserService {
    List<UserRepresentation> findAllUsers();
    List<UserRepresentation> searchUserByUsername(String username);
    UserRepresentation createUser(CreateUserDTO createUserDTO);
    String getLoggedInUserId();
    void deleteUser(String userId);
    void updateUser(String userId, CreateUserDTO createUserDTO);
}
