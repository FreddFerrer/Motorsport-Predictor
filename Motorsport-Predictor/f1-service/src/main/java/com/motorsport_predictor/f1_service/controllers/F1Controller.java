package com.motorsport_predictor.f1_service.controllers;

import com.motorsport_predictor.f1_service.dto.CircuitDTO;
import com.motorsport_predictor.f1_service.dto.RaceDTO;
import com.motorsport_predictor.f1_service.dto.request.RaceResultRequestDTO;
import com.motorsport_predictor.f1_service.exceptions.BadRequestException;
import com.motorsport_predictor.f1_service.services.ICircuitService;
import com.motorsport_predictor.f1_service.services.IDriverService;
import com.motorsport_predictor.f1_service.services.IRaceService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/f1")
@CrossOrigin
@AllArgsConstructor
public class F1Controller {
    private final ICircuitService circuitService;
    private final IDriverService driverService;
    private final IRaceService raceService;

    @Operation(
            summary = "Obtener todos los circuitos",
            description = "Devuelve una lista paginada de circuitos de Fórmula 1. Es un endpoint protegido que requiere autenticación y autorización (roles: ADMIN o USER).",
            security = @SecurityRequirement(name = "bearerAuth")
    )
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Lista de circuitos obtenida exitosamente",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            schema = @Schema(implementation = CircuitDTO.class),
                            examples = {
                                    @ExampleObject(
                                            name = "200 Response",
                                            summary = "Respuesta exitosa",
                                            value = "[{\"circuitName\": \"Monza\", \"locality\": \"Monza\", \"country\": \"Italy\"}," +
                                                    "{\"circuitName\": \"Silverstone\", \"locality\": \"Silverstone\", \"country\": \"United Kingdom\"}]"
                                    )
                            }
                    )
            ),
            @ApiResponse(
                    responseCode = "400",
                    description = "Error en la solicitud (Bad Request)",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = {
                                    @ExampleObject(
                                            name = "400 Response",
                                            summary = "Error de solicitud",
                                            value = "{\"timestamp\": \"2024-09-05T12:34:56.789\", \"message\": \"Invalid request parameters\"}"
                                    )
                            }
                    )
            ),
            @ApiResponse(
                    responseCode = "401",
                    description = "No autorizado (Unauthorized)",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = {
                                    @ExampleObject(
                                            name = "401 Response",
                                            summary = "No autorizado",
                                            value = "{\"timestamp\": \"2024-09-05T12:34:56.789\", \"message\": \"Unauthorized access\"}"
                                    )
                            }
                    )
            )
    })
    @GetMapping("/circuits")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getAllCircuits(@PageableDefault(size = 30) Pageable pageable){
        try {
            return ResponseEntity.ok(circuitService.getAllCircuit(pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/drivers")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getAllDrivers(){
        try {
            return ResponseEntity.ok(driverService.getAllDrivers());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    // Internal endpoint
    @GetMapping("/drivers/{driverId}/exist")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<Boolean> getDriverById(@PathVariable Long driverId) {
        try {
            boolean exists = driverService.existById(driverId);
            return ResponseEntity.ok().body(exists);
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Obtener todas las carreras",
            description = "Devuelve una lista de todas las carreras de la temporada de Fórmula 1. Este endpoint es público y no requiere autenticación."
    )
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Lista de carreras obtenida exitosamente",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            schema = @Schema(implementation = RaceDTO.class),
                            examples = {
                                    @ExampleObject(
                                            name = "200 Response",
                                            summary = "Respuesta exitosa",
                                            value = "[{\"season\": \"2024\", \"round\": 1, \"raceName\": \"Bahrain Grand Prix\", " +
                                                    "\"circuit\": {\"circuitName\": \"Bahrain International Circuit\", \"locality\": \"Sakhir\", \"country\": \"Bahrain\"}, " +
                                                    "\"date\": \"2024-03-05\", \"time\": \"15:00\"}," +
                                                    "{\"season\": \"2024\", \"round\": 2, \"raceName\": \"Saudi Arabian Grand Prix\", " +
                                                    "\"circuit\": {\"circuitName\": \"Jeddah Corniche Circuit\", \"locality\": \"Jeddah\", \"country\": \"Saudi Arabia\"}, " +
                                                    "\"date\": \"2024-03-19\", \"time\": \"20:00\"}]"
                                    )
                            }
                    )
            ),
            @ApiResponse(
                    responseCode = "400",
                    description = "Error en la solicitud (Bad Request)",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = {
                                    @ExampleObject(
                                            name = "400 Response",
                                            summary = "Error de solicitud",
                                            value = "{\"timestamp\": \"2024-09-05T12:34:56.789\", \"message\": \"Invalid request parameters\"}"
                                    )
                            }
                    )
            )
    })
    @GetMapping("/races")
    public ResponseEntity<?> getAllRaces(){
        try {
            return ResponseEntity.ok(raceService.getAllRaces());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/races/{raceId}")
    public ResponseEntity<?> getRaceById(@PathVariable Long raceId){
        try {
            return ResponseEntity.ok(raceService.getRaceById(raceId));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    // Internal endpoint
    @GetMapping("/races/{raceId}/exist")
    public ResponseEntity<?> existRaceId(@PathVariable Long raceId){
        try {
            return ResponseEntity.ok(raceService.existById(raceId));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/races/nextRace")
    public ResponseEntity<?> getNextRace(){
        try {
            return ResponseEntity.ok(raceService.getNextRace());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @PostMapping("/races/{raceId}/results")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> uploadF1RaceResult(@PathVariable Long raceId, @RequestBody @Valid RaceResultRequestDTO raceResult){
        try {
            raceService.uploadRaceResults(raceId, raceResult);
            return ResponseEntity.status(HttpStatus.CREATED).body("successfully");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }
}
