package com.motorsport_predictor.predictions_service.controllers;

import com.motorsport_predictor.predictions_service.dto.request.PredictionsRequestDTO;
import com.motorsport_predictor.predictions_service.exceptions.BadRequestException;
import com.motorsport_predictor.predictions_service.services.IF1PredictionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/predictions")
@CrossOrigin
@RequiredArgsConstructor
public class F1PredictionController {
    private final IF1PredictionService predictionService;

    @Operation(hidden = true)
    @GetMapping("/userEmail")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getUserEmail() {
        try {
            return ResponseEntity.ok(predictionService.getUserEmail());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Realizar predicción en una carrera para un grupo específico",
            description = """
        Este endpoint permite que un miembro de un grupo realice predicciones sobre una carrera de Fórmula 1.
        El miembro debe pertenecer al grupo, y solo puede realizar hasta 10 predicciones por carrera. 
        Además, se enviará una notificación por correo electrónico al usuario que realizó la predicción.
        
        ### Reglas:
        - Los pilotos en la predicción no pueden repetirse.
        - Las posiciones en la predicción deben ser únicas y estar entre 1 y 10.
        - Si ya se han realizado 10 predicciones para una carrera, no se permitirá realizar más.
        - Solo los miembros de un grupo pueden realizar predicciones para ese grupo.
        
        ### Restricciones:
        - Solo se permite realizar hasta 10 predicciones por usuario para una carrera.
        - Si el grupo o la carrera no existen, o el usuario no pertenece al grupo, se lanzará una excepción.
    """,
            security = @SecurityRequirement(name = "Bearer Authentication")
    )
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "201",
                    description = "Predicciones creadas exitosamente",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = {
                                    @ExampleObject(
                                            name = "201 Response",
                                            summary = "Predicciones creadas con éxito",
                                            value = "{\"message\": \"successfully\"}"
                                    )
                            }
                    )
            ),
            @ApiResponse(
                    responseCode = "400",
                    description = "Solicitud incorrecta o datos inválidos",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = {
                                    @ExampleObject(
                                            name = "400 Response",
                                            summary = "Error si el usuario no pertenece al grupo",
                                            value = "{\"message\": \"El usuario no pertenece al grupo.\", \"path\": \"uri=/api/f1/{memberGroupId}/{raceId}/newPrediction\"}"
                                    ),
                                    @ExampleObject(
                                            name = "400 Response",
                                            summary = "Error si se ingresan más de 10 predicciones",
                                            value = "{\"message\": \"Solo se permiten hasta 10 predicciones por solicitud.\", \"path\": \"uri=/api/f1/{memberGroupId}/{raceId}/newPrediction\"}"
                                    ),
                                    @ExampleObject(
                                            name = "400 Response",
                                            summary = "Error si un piloto no existe",
                                            value = "{\"message\": \"El piloto con ID 25 no existe.\", \"path\": \"uri=/api/f1/{memberGroupId}/{raceId}/newPrediction\"}"
                                    )
                            }
                    )
            ),
            @ApiResponse(
                    responseCode = "403",
                    description = "Prohibido, el usuario no tiene permisos",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = {
                                    @ExampleObject(
                                            name = "403 Response",
                                            summary = "Acceso no autorizado",
                                            value = "{\"message\": \"Access denied\", \"path\": \"uri=/api/f1/{memberGroupId}/{raceId}/newPrediction\"}"
                                    )
                            }
                    )
            )
    })
    @PostMapping("/f1/{memberGroupId}/{raceId}/newPrediction")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> newPredictions(@PathVariable Long memberGroupId,
                                            @PathVariable Long raceId,
                                            @RequestBody @Valid PredictionsRequestDTO predictionsRequestDTO) {
        try {
            predictionService.createPrediction(memberGroupId, raceId, predictionsRequestDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body("successfully");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }
}
