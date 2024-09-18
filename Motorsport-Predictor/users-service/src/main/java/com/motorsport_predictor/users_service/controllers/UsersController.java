package com.motorsport_predictor.users_service.controllers;

import com.motorsport_predictor.users_service.dto.request.CreateUserDTO;
import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.service.IUserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@CrossOrigin
public class UsersController {
    private final IUserService userService;

    @Operation(
            summary = "Obtiene todos los usuarios (solo para ROLE_ADMIN)",
            description = "Este endpoint está protegido y solo puede ser accedido por usuarios con el rol de ADMIN. "
                    + "Devuelve una lista paginada de usuarios del sistema.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Usuarios obtenidos exitosamente",
                            content = @Content(mediaType = "application/json", schema = @Schema(implementation = UserRepresentation.class))),
                    @ApiResponse(responseCode = "403", description = "Acceso denegado",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Access denied",
                    "path": "uri=/api/users/"
                }
            """)))
            }
    )    @GetMapping("/")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> findAllUsers(@PageableDefault(size = 10) @Parameter(hidden = true) Pageable pageable){
        try {
            return ResponseEntity.ok(userService.findAllUsers(pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Buscar un usuario por su username (protegido)",
            description = "Este endpoint permite a los usuarios con los roles ADMIN o USER buscar a un usuario por su nombre de usuario (username). Devuelve la información completa del usuario si se encuentra.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Usuario encontrado exitosamente",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                [
                    {
                        "id": "a5b733dd-0ce3-4a92-82d7-69a4e9cf2ec1",
                        "username": "basic_user",
                        "firstName": "Basic",
                        "lastName": "User",
                        "email": "basic_user@gmail.com",
                        "emailVerified": true,
                        "attributes": {
                            "nationality": [
                                "American"
                            ]
                        },
                        "createdTimestamp": 1722863434120,
                        "enabled": true,
                        "totp": false,
                        "access": {
                            "manageGroupMembership": true,
                            "view": true,
                            "mapRoles": true,
                            "impersonate": true,
                            "manage": true
                        }
                    }
                ]
            """))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta o usuario no encontrado",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Invalid user: 'username'",
                    "path": "uri=/api/users/search/'username'"
                }
            """))),
                    @ApiResponse(responseCode = "403", description = "Acceso denegado",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Access denied",
                    "path": "uri=/api/users/search/'username'"
                }
            """)))
            }
    )
    @GetMapping("/search/{username}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> searchUserByUsername(@PathVariable String username){
        try {
            return ResponseEntity.ok(userService.searchUserByUsername(username));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    // Intern endpoint
    @Operation(hidden = true)
    @GetMapping("/loggedUser")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getUserLoggedId(){
        try {
            return ResponseEntity.ok(userService.getLoggedInUserId());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    // Intern endpoint
    @Operation(hidden = true)
    @GetMapping("/email")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getUserEmail(){
        try {
            return ResponseEntity.ok(userService.getUserEmail());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Crear un nuevo usuario",
            requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    required = true,
                    content = @Content(mediaType = "application/json",
                            schema = @Schema(implementation = CreateUserDTO.class),
                            examples = @ExampleObject(value = """
                {
                    "username": "newuser123",
                    "firstName": "John",
                    "lastName": "Doe",
                    "nationality": "American",
                    "email": "john.doe@example.com",
                    "password": "Password@123"
                }
            """))
            ),
            responses = {
                    @ApiResponse(responseCode = "201", description = "Usuario creado exitosamente",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "id": null,
                    "username": "newuser123",
                    "firstName": "John",
                    "lastName": "Doe",
                    "email": "john.doe@example.com",
                    "emailVerified": false,
                    "attributes": {
                        "nationality": [
                            "American"
                        ]
                    },
                    "enabled": true
                }
            """))),
                    @ApiResponse(responseCode = "400", description = "Error durante la creación del usuario",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Error during registration",
                    "errors": {
                        "nationality": "no debe ser nulo",
                        "username": "must have between 6 and 32 characters"
                    },
                    "path": "uri=/api/users/create"
                }
            """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Internal server error",
                    "path": "uri=/api/users/create"
                }
            """)))
            }
    )
    @PostMapping("/create")
    public ResponseEntity<?> createUser(@Valid @RequestBody CreateUserDTO userDTO) {
        try {
            UserRepresentation response = userService.createUser(userDTO);
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(response);
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Actualizar un usuario existente",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    required = true,
                    content = @Content(mediaType = "application/json",
                            schema = @Schema(implementation = CreateUserDTO.class),
                            examples = @ExampleObject(value = """
                {
                    "username": "updatedUser123",
                    "firstName": "John",
                    "lastName": "Doe",
                    "nationality": "American",
                    "email": "john.doe_updated@example.com",
                    "password": "UpdatedPassword@123",
                    "roles": ["ROLE_USER"]
                }
            """))
            ),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Usuario actualizado exitosamente",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                "User updated successfully"
            """))),
                    @ApiResponse(responseCode = "400", description = "Error durante la actualización del usuario",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Error during update",
                    "errors": {
                        "email": "must be a valid email address"
                    },
                    "path": "uri=/api/users/update/{userId}"
                }
            """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Internal server error",
                    "path": "uri=/api/users/update/{userId}"
                }
            """)))
            }
    )
    @PutMapping("/update/{userId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> updateUser(@PathVariable String userId, @RequestBody CreateUserDTO userDTO){
        try {
            userService.updateUser(userId, userDTO);
            return ResponseEntity.ok("User updated successfully");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Eliminar un usuario por ID",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "204", description = "Usuario eliminado exitosamente",
                            content = @Content),
                    @ApiResponse(responseCode = "400", description = "Error durante la eliminación del usuario",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Invalid user",
                    "path": "uri=/api/users/delete/{userId}"
                }
            """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Internal server error",
                    "path": "uri=/api/users/delete/{userId}"
                }
            """)))
            }
    )
    @DeleteMapping("/delete/{userId}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> deleteUser(@PathVariable String userId){
        userService.deleteUser(userId);
        return ResponseEntity.noContent().build();
    }
}