package com.motorsport_predictor.gateway_server.service.impl;

import com.motorsport_predictor.gateway_server.dto.request.CreateUserDTO;
import com.motorsport_predictor.gateway_server.dto.request.LoginRequestDTO;
import com.motorsport_predictor.gateway_server.exceptions.BadRequestException;
import com.motorsport_predictor.gateway_server.exceptions.EmailVerificationException;
import com.motorsport_predictor.gateway_server.exceptions.ResourceNotFoundException;
import com.motorsport_predictor.gateway_server.service.IUserService;
import com.motorsport_predictor.gateway_server.util.KeycloakProvider;
import jakarta.validation.Valid;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Response;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.UsersResource;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RoleRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements IUserService {

    @Value("${KC_CLIENT_ID}")
    private String clientId;

    @Value("${KC_CLIENT_SECRET}")
    private String clientSecret;

    @Override
    public Map<String, Object> login(@Valid LoginRequestDTO loginRequestDTO) {
        if (loginRequestDTO.getPassword() == null || loginRequestDTO.getPassword().isEmpty()) {
            throw new IllegalArgumentException("Password field is required and cannot be empty.");
        }

        String url = "http://keycloak-server:9090/realms/microservices-motorsport-predictor-realm/protocol/openid-connect/token";

        String body = "client_id=" + clientId +
                "&client_secret=" + clientSecret +
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

            return responseBody;
        } else {
            throw new RuntimeException("Error en la autenticación: " + response.getStatusCode());
        }
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

            try {
                // Intentamos enviar el correo de verificación
                emailVerification(userId);
            } catch (EmailVerificationException e) {
                // Si falla la verificación, eliminamos al usuario recién creado
                usersResource.delete(userId);
                throw new BadRequestException("Error verifying email, user creation cancelled.");
            }

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

            return userRepresentation;

        } else if (status == 409) {
            log.error("User exist already!");
            throw new BadRequestException("User or email already exist!");
        } else {
            log.error("Error creating user, please contact with the administrator.");
            throw new BadRequestException("Error creating user, please contact with the administrator!");
        }
    }

    public void emailVerification(String userId) {
        UsersResource usersResource = KeycloakProvider.getUserResource();
        try {
            usersResource.get(userId).sendVerifyEmail();
            log.info("Email de verificación enviado exitosamente al usuario con ID: " + userId);
        } catch (Exception e) {
            // Error email sender handler
            log.error("No se pudo enviar el email de verificación al usuario con ID: " + userId, e);
            throw new EmailVerificationException("Failed to send verification email.");
        }
    }
}