package com.motorsport_predictor.gateway_server.auth.controller;

import com.motorsport_predictor.gateway_server.dto.request.LoginRequestDTO;
import com.motorsport_predictor.gateway_server.service.IUserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Tag(name = "Authentication", description = "Controlador para autenticación de usuarios. \n\n" +
        "**Usuarios de prueba**:\n\n" +
        "- **usuario_prueba_1** / Password@PruebaUser\n" +
        "- **usuario_prueba_2** / Password@PruebaUser")
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
}
