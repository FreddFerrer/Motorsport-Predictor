package com.motorsport_predictor.users_service.util;

import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.exceptions.ResourceNotFoundException;
import jakarta.ws.rs.NotFoundException;
import org.jboss.resteasy.client.jaxrs.internal.ResteasyClientBuilderImpl;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.UsersResource;
import org.keycloak.representations.idm.UserRepresentation;

import java.util.ArrayList;
import java.util.List;

public class KeycloakProvider {
    private static final String SERVER_URL = "http://keycloak-server:8080";
    private static final String REALM_NAME = "microservices-motorsport-predictor-realm";
    private static final String REALM_MASTER = "master";
    private static final String ADMIN_CLI = "admin-cli";
    private static final String USER_CONSOLE = "admin";
    private static final String PASSWORD_CONSOLE = "admin";
    private static final String CLIENT_SECRET = "cKqUA6aHPFAU4kaZjXe7FY1mw1VwVxxh";

    public static RealmResource getRealmResource() {
        Keycloak keycloak = KeycloakBuilder.builder()
                .serverUrl(SERVER_URL)
                .realm(REALM_MASTER)
                .clientId(ADMIN_CLI)
                .username(USER_CONSOLE)
                .password(PASSWORD_CONSOLE)
                .clientSecret(CLIENT_SECRET)
                .resteasyClient(new ResteasyClientBuilderImpl()
                        .connectionPoolSize(10)
                        .build())
                .build();

        return keycloak.realm(REALM_NAME);
    }

    public static UsersResource getUserResource() {
        RealmResource realmResource = getRealmResource();
        return realmResource.users();
    }

    public static UserRepresentation getUserById(String userId) {
        UsersResource usersResource = getUserResource();
        try {
            return usersResource.get(userId).toRepresentation();
        } catch (NotFoundException e) {
            throw new ResourceNotFoundException(userId);
        }
    }

    public static UserRepresentation getUserByUsername(String username) {
        UsersResource usersResource = getUserResource();
        List<UserRepresentation> users = usersResource.search(username);
        if (users != null && !users.isEmpty()) {
            return users.get(0); // Assuming the username is unique
        }
        throw new ResourceNotFoundException(username);
    }

    public static List<UserRepresentation> getUsersByIds(List<String> userIds) {
        UsersResource usersResource = getUserResource();
        List<UserRepresentation> users = new ArrayList<>();

        for (String userId : userIds) {
            try {
                UserRepresentation user = usersResource.get(userId).toRepresentation();
                users.add(user);
            } catch (ResourceNotFoundException e) {
                throw  new BadRequestException(userId);
            }
        }
        return users;
    }
}
