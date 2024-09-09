package com.motorsport_predictor.users_service.service.impl;

import com.motorsport_predictor.users_service.dto.request.CreateUserDTO;
import com.motorsport_predictor.users_service.dto.request.LoginRequestDTO;
import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.exceptions.ResourceNotFoundException;
import com.motorsport_predictor.users_service.service.IUserService;
import com.motorsport_predictor.users_service.util.KeycloakProvider;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Response;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.OAuth2Constants;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.admin.client.resource.UsersResource;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements IUserService {

    @Override
    public Page<UserRepresentation> findAllUsers(Pageable pageable) {

        UsersResource usersResource = KeycloakProvider.getUserResource();

        // Pagination in Keycloak is implemented using `first` and `max` as parameters to control the range of results returned.
        int firstResult = pageable.getPageNumber() * pageable.getPageSize();
        int maxResults = pageable.getPageSize();

        List<UserRepresentation> users = usersResource.list(firstResult, maxResults);

        int totalUsers = usersResource.count();

        return new PageImpl<>(users, pageable, totalUsers);
    }

    @Override
    public List<UserRepresentation> searchUserByUsername(String username) {
        List<UserRepresentation> user = KeycloakProvider.getUserResource()
                .searchByUsername(username, true);

        if (user.isEmpty()) {
            throw new BadRequestException("Invalid user");
        }

        return user;
    }

    @Override
    public UserRepresentation createUser(@NonNull CreateUserDTO userDTO) {

        int status = 0;
        UsersResource usersResource = KeycloakProvider.getUserResource();

        UserRepresentation userRepresentation = new UserRepresentation();
        userRepresentation.setFirstName(userDTO.getFirstName());
        userRepresentation.setLastName(userDTO.getLastName());
        userRepresentation.setEmail(userDTO.getEmail());
        userRepresentation.setUsername(userDTO.getUsername());
        userRepresentation.setEnabled(true);
        userRepresentation.setEmailVerified(false);
        userRepresentation.singleAttribute("nationality", userDTO.getNationality());

        Response response = usersResource.create(userRepresentation);

        status = response.getStatus();

        if (status == 201) {
            String path = response.getLocation().getPath();
            String userId = path.substring(path.lastIndexOf("/") + 1);

            CredentialRepresentation credentialRepresentation = new CredentialRepresentation();
            credentialRepresentation.setTemporary(false);
            credentialRepresentation.setType(CredentialRepresentation.PASSWORD);
            credentialRepresentation.setValue(userDTO.getPassword());

            usersResource.get(userId).resetPassword(credentialRepresentation);

            RealmResource realmResource = KeycloakProvider.getRealmResource();

            List<RoleRepresentation> rolesRepresentation;

            if (userDTO.getRoles() == null || userDTO.getRoles().isEmpty()) {
                rolesRepresentation = List.of(realmResource.roles().get("USER").toRepresentation());
            } else {
                rolesRepresentation = realmResource.roles()
                        .list()
                        .stream()
                        .filter(role -> userDTO.getRoles()
                                .stream()
                                .anyMatch(roleName -> roleName.equalsIgnoreCase(role.getName())))
                        .toList();
            }

            realmResource.users().get(userId).roles().realmLevel().add(rolesRepresentation);

            emailVerification(userId);

            return userRepresentation;

        } else if (status == 409) {
            log.error("User exist already!");
            throw new BadRequestException("User or email already exist!");
        } else {
            log.error("Error creating user, please contact with the administrator.");
            throw new BadRequestException("Error creating user, please contact with the administrator!");
        }
    }

    @Override
    public Map<String, Object> login(LoginRequestDTO loginRequestDTO) {
        String url = "http://localhost:9090/realms/microservices-motorsport-predictor-realm/protocol/openid-connect/token";

        String body = "client_id=microservices-motorsport-client" +
                "&client_secret=cKqUA6aHPFAU4kaZjXe7FY1mw1VwVxxh" +
                "&grant_type=password" +
                "&username=" + loginRequestDTO.getUsername() +
                "&password=" + loginRequestDTO.getPassword() +
                "&scope=openid";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<String> request = new HttpEntity<>(body, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, request, Map.class);

        // Verificar el estado de la respuesta
        if (response.getStatusCode() == HttpStatus.OK) {
            Map<String, Object> responseBody = response.getBody();
            //String accessToken = (String) responseBody.get("access_token");

            // Retornar el token como un mapa
            //Map<String, String> result = new HashMap<>();
            //result.put("access_token", accessToken);
            return responseBody;
        } else {
            throw new RuntimeException("Error en la autenticación: " + response.getStatusCode());
        }
    }

    public void emailVerification(String userId){
        UsersResource usersResource = KeycloakProvider.getUserResource();
        try {
            usersResource.get(userId).sendVerifyEmail();
            log.info("Email de verificación enviado exitosamente al usuario con ID: " + userId);
        } catch (WebApplicationException e) {
            // Error email sender handler
            log.error("No se pudo enviar el email de verificación al usuario con ID: " + userId, e);
            throw new ResourceNotFoundException("email");
        }
    }


    @Override
    public String getLoggedInUserId() {
        return getLoggedUserId();
    }

    @Override
    public String getUserEmail() {
        String userId = getLoggedInUserId();

        UserRepresentation userRepresentation = KeycloakProvider.getUserById(userId);

        return userRepresentation.getEmail();
    }

    @Override
    public void deleteUser(String userId) {
        try {
            KeycloakProvider.getUserResource()
                    .get(userId)
                    .remove();
        } catch (Exception e) {
            throw new BadRequestException("Invalid user");
        }
    }

    @Override
    public void updateUser(String userId, CreateUserDTO userDTO) {
        CredentialRepresentation credentialRepresentation = new CredentialRepresentation();
        credentialRepresentation.setTemporary(false);
        credentialRepresentation.setType(OAuth2Constants.PASSWORD);
        credentialRepresentation.setValue(userDTO.getPassword());

        UserRepresentation user = new UserRepresentation();
        user.setUsername(userDTO.getUsername());
        user.setFirstName(userDTO.getFirstName());
        user.setLastName(userDTO.getLastName());
        user.setEmail(userDTO.getEmail());
        user.singleAttribute("nationality", userDTO.getNationality());
        user.setEnabled(true);
        user.setEmailVerified(true);
        user.setCredentials(Collections.singletonList(credentialRepresentation));

        UserResource usersResource = KeycloakProvider.getUserResource().get(userId);
        usersResource.update(user);
    }

    public static String getLoggedUserId() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            throw new BadRequestException("User not authenticated");
        }

        return authentication.getName();
    }
}