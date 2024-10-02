package com.motorsport_predictor.gateway_server.auth.controller;

import com.motorsport_predictor.gateway_server.dto.request.CreateUserDTO;
import com.motorsport_predictor.gateway_server.dto.request.LoginRequestDTO;
import com.motorsport_predictor.gateway_server.exceptions.BadRequestException;
import com.motorsport_predictor.gateway_server.service.IUserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Tag(name = "Authentication", description = "Controlador para autenticación de usuarios. \n\n" +
        "**Usuarios de prueba**:\n\n" +
        "- **usuario_prueba_1** / Password@123\n" +
        "- **usuario_prueba_2** / Password@123")
@CrossOrigin(origins = "*")
public class AuthController {

    private final IUserService userService;

    @Operation(summary = "User login")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Login successful",
                    content = @Content(mediaType = "application/json",
                            schema = @Schema(example = "{\n" +
                                    "    \"access_token\": \"eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJCcHZEdWV2UjlvRjdpaDRFQ2RON3hxQzBSaldzc3JPelRhdkZ1dGZNWnVnIn0...\",\n" +
                                    "    \"expires_in\": 300,\n" +
                                    "    \"refresh_expires_in\": 1800,\n" +
                                    "    \"refresh_token\": \"eyJhbGciOiJIUzUxMiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIwZTQ0N2RjNi0wNzk3LTQ5YTItYTZlMy1iZjhjZDY5ZmY1ODcifQ...\",\n" +
                                    "    \"token_type\": \"Bearer\",\n" +
                                    "    \"id_token\": \"eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJCcHZEdWV2UjlvRjdpaDRFQ2RON3hxQzBSaldzc3JPelRhdkZ1dGZNWnVnIn0...\",\n" +
                                    "    \"scope\": \"openid profile email\"\n" +
                                    "}")
                    )),
            @ApiResponse(responseCode = "400", description = "Validation error: Required field missing",
                    content = @Content(mediaType = "application/json",
                            schema = @Schema(example = "{\n" +
                                    "    \"timestamp\": \"2024-09-18T02:00:11.179+00:00\",\n" +
                                    "    \"path\": \"/api/auth/login\",\n" +
                                    "    \"status\": 400,\n" +
                                    "    \"error\": \"Bad Request\",\n" +
                                    "    \"message\": \"Validation failed: Required field\",\n" +
                                    "    \"errors\": [\n" +
                                    "        {\n" +
                                    "            \"field\": \"password\",\n" +
                                    "            \"defaultMessage\": \"Required field\"\n" +
                                    "        }\n" +
                                    "    ]\n" +
                                    "}"))
            ),
            @ApiResponse(responseCode = "401", description = "Validation error: Invalid Credentials",
                    content = @Content(mediaType = "string",
                            schema = @Schema(example = "Invalid credentials"))
            )
    })
    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequestDTO loginRequest) {
        try {
            Map<String, Object> response = userService.login(loginRequest);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
        }
    }

    @Operation(summary = "Create a new user",
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
                    "password": "UpdatedPassword@123"
                }
            """))
            ),
            responses = {
                    @ApiResponse(responseCode = "201", description = "User created successfully",
                            content = @Content(mediaType
                                    = "application/json",
                                    schema = @Schema(implementation = UserRepresentation.class))),
                    @ApiResponse(responseCode = "400", description
                            = "Validation error: Required field missing",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(example = "{\n" +
                                            "    \"timestamp\": \"2024-09-18T02:00:11.179+00:00\",\n" +
                                            "    \"path\": \"/api/auth/create\",\n" +
                                            "    \"status\": 400,\n" +
                                            "    \"error\": \"Bad Request\",\n" +
                                            "    \"message\": \"Validation failed: Required field\",\n" +
                                            "    \"errors\": [\n" +
                                            "        {\n" +
                                            "            \"field\": \"username\",\n" +
                                            "            \"defaultMessage\": \"Required field\"\n" +
                                            "        }\n" +
                                            "    ]\n" +
                                            "}"))
                    ),
                    @ApiResponse(responseCode = "409", description = "Conflict: User already exists",
                            content = @Content(mediaType = "string",
                                    schema = @Schema(example = "User already exists"))
                    )
            })
    @PostMapping("/create")
    public ResponseEntity<?> createUser(@Valid @RequestBody CreateUserDTO createUserRequest) {
        try {
            UserRepresentation response = userService.createUser(createUserRequest);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }
}
