package com.motorsport_predictor.users_service.service;

import com.motorsport_predictor.users_service.dto.request.CreateUserDTO;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IUserService {
    Page<UserRepresentation> findAllUsers(Pageable pageable);
    List<UserRepresentation> searchUserByUsername(String username);
    UserRepresentation createUser(CreateUserDTO createUserDTO);
    String getLoggedInUserId();
    String getUserEmail();
    void deleteUser(String userId);
    void updateUser(String userId, CreateUserDTO createUserDTO);
}