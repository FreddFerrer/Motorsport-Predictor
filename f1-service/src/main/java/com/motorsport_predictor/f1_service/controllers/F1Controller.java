package com.motorsport_predictor.f1_service.controllers;

import com.motorsport_predictor.f1_service.dto.CircuitDTO;
import com.motorsport_predictor.f1_service.dto.DriverDTO;
import com.motorsport_predictor.f1_service.dto.RaceDTO;
import com.motorsport_predictor.f1_service.dto.request.RaceResultRequestDTO;
import com.motorsport_predictor.f1_service.exceptions.BadRequestException;
import com.motorsport_predictor.f1_service.models.entities.Driver;
import com.motorsport_predictor.f1_service.services.ICircuitService;
import com.motorsport_predictor.f1_service.services.IDriverService;
import com.motorsport_predictor.f1_service.services.IRaceService;
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import io.swagger.v3.oas.annotations.Hidden;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/f1")
@RequiredArgsConstructor
@Tag(name = "F1 controller", description = "Controlador dedicado para la categoria de Formula 1. \n\n")
public class F1Controller {
    private final ICircuitService circuitService;
    private final IDriverService driverService;
    private final IRaceService raceService;

    @Operation(
            summary = "Obtener todos los circuitos",
            description = "Devuelve una lista paginada de circuitos de Fórmula 1. Es un endpoint protegido que requiere autenticación y autorización (roles: ADMIN o USER).",
            security = @SecurityRequirement(name = "Bearer Authentication")
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
                                            value = "{\"message\": \"Bad request.\", \"path\": \"uri=/api/f1/circuits\"}"
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
                                            value = "{\"message\": \"Access denied\", \"path\": \"uri=/api/f1/circuits\"}"
                                    )
                            }
                    )
            )
    })
    @GetMapping("/circuits")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getAllCircuits(@PageableDefault(size = 30) @Parameter(hidden = true) Pageable pageable){
        try {
            return ResponseEntity.ok(circuitService.getAllCircuit(pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Obtener todos los pilotos",
            description = "Devuelve una lista paginada de los pilotos de Fórmula 1. Es un endpoint protegido que requiere autenticación y autorización (roles: ADMIN o USER).",
            security = @SecurityRequirement(name = "Bearer Authentication")
    )
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Lista de pilotos obtenida exitosamente",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            schema = @Schema(implementation = DriverDTO.class),
                            examples = {
                                    @ExampleObject(
                                            name = "200 Response",
                                            summary = "Respuesta exitosa",
                                            value = "[{\"name\": \"Carlos Sainz\", \"nationality\": \"ESP\", \"Team\": {\"name\": \"Ferrari\"}}," +
                                                    "{\"name\": \"Max Verstappen\", \"nationality\": \"NED\", \"Team\": {\"name\": \"Red Bull Racing Honda RBPT\"}}]"
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
                                            value = "{\"message\": \"Bad request.\", \"path\": \"uri=/api/f1/drivers\"}"
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
                                            value = "{\"message\": \"Access denied\", \"path\": \"uri=/api/f1/drivers\"}"
                                    )
                            }
                    )
            )
    })
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
    @Hidden
    @GetMapping("/drivers/ids")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<List<Long>> getDriverIdsByShortnames(@RequestParam List<String> shortnames) {
        try {
            List<Long> driverIds = driverService.getDriverIdsByShortname(shortnames);
            return ResponseEntity.ok().body(driverIds);
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    // Internal endpoint
    @Hidden
    @GetMapping("/drivers/id")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<Long> getDriverIdByShortname(@RequestParam String shortname) {
        Optional<Driver> driver = driverService.getDriverIdByShortname(shortname);

        // Si el piloto no existe, devuelve un error 404
        if (driver.isPresent()) {
            return ResponseEntity.ok(driver.get().getId());  // Devuelve solo el ID del piloto
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "El piloto " + shortname + " no existe.");
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
                                            value = "{\"message\": \"Bad request.\", \"path\": \"uri=/api/f1/circuits\"}"
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

    @Operation(
            summary = "Obtener información de una carrera por su ID",
            description = "Devuelve la información de una carrera específica identificada por su ID. Si la carrera no existe, devuelve un error 404."
    )
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Carrera obtenida exitosamente",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            schema = @Schema(implementation = RaceDTO.class),
                            examples = {
                                    @ExampleObject(
                                            name = "200 Response",
                                            summary = "Carrera obtenida exitosamente",
                                            value = "{\"season\": \"2024\", \"round\": 1, \"raceName\": \"Bahrain Grand Prix\", " +
                                                    "\"circuit\": {\"circuitName\": \"Bahrain International Circuit\", \"locality\": \"Sakhir\", \"country\": \"Bahrain\"}, " +
                                                    "\"date\": \"2024-03-05\", \"time\": \"15:00\"}"
                                    )
                            }
                    )
            ),
            @ApiResponse(
                    responseCode = "400",
                    description = "Carrera no encontrada",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = {
                                    @ExampleObject(
                                            name = "404 Response",
                                            summary = "Carrera no encontrada",
                                            value = "{\"message\": \"No hay registros de raceId '67' en el sistema\", \"path\": \"uri=/api/f1/races/'67'\"}"
                                    )
                            }
                    )
            ),
    })
    @GetMapping("/races/{raceId}")
    public ResponseEntity<?> getRaceById(@PathVariable Long raceId){
        try {
            return ResponseEntity.ok(raceService.getRaceById(raceId));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    // Internal endpoint
    @Hidden
    @GetMapping("/races/{raceId}/exist")
    public ResponseEntity<?> existRaceId(@PathVariable Long raceId){
        try {
            return ResponseEntity.ok(raceService.existById(raceId));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Obtener la siguiente carrera programada",
            description = "Devuelve la información de la próxima carrera programada en el calendario de Fórmula 1."
    )
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "Siguiente carrera obtenida exitosamente",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            schema = @Schema(implementation = RaceDTO.class),
                            examples = {
                                    @ExampleObject(
                                            name = "200 Response",
                                            summary = "Siguiente carrera obtenida exitosamente",
                                            value = "{\"season\": \"2024\", \"round\": 5, \"raceName\": \"Spanish Grand Prix\", " +
                                                    "\"circuit\": {\"circuitName\": \"Circuit de Barcelona-Catalunya\", \"locality\": \"Montmeló\", \"country\": \"Spain\"}, " +
                                                    "\"date\": \"2024-05-10\", \"time\": \"14:00\"}"
                                    )
                            }
                    )
            ),
            @ApiResponse(
                    responseCode = "404",
                    description = "No se encontró una próxima carrera",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = {
                                    @ExampleObject(
                                            name = "404 Response",
                                            summary = "No se encontró la próxima carrera",
                                            value = "{\"message\": \"HTTP not found\", \"path\": \"uri=/api/f1/races/nextRace\"}"
                                    )
                            }
                    )
            ),
            @ApiResponse(
                    responseCode = "400",
                    description = "Solicitud incorrecta (Bad Request)",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = {
                                    @ExampleObject(
                                            name = "400 Response",
                                            summary = "Error en la solicitud",
                                            value = "{\"message\": \"Bad request.\", \"path\": \"uri=/api/f1/races/nextRace\"}"
                                    )
                            }
                    )
            )
    })
    @GetMapping("/races/nextRace")
    public ResponseEntity<?> getNextRace(){
        try {
            return ResponseEntity.ok(raceService.getNextRace());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Cargar los resultados de una carrera. ",
            description = "Tarea reservada para el usuario tipo 'ADMIN'",
            security = @SecurityRequirement(name = "Bearer Authentication")
    )
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "201",
                    description = "Resultados cargados exitosamente",
                    content = @Content(
                            mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = {
                                    @ExampleObject(
                                            name = "201 Response",
                                            summary = "Resultados cargados exitosamente",
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
                                            summary = "Error si se ingresan más de 10 pilotos",
                                            value = "{\"message\": \"Solo se permiten hasta 10 pilotos.\", \"path\": \"uri=/api/f1/{memberGroupId}/{raceId}/newPrediction\"}"
                                    ),
                                    @ExampleObject(
                                            name = "400 Response",
                                            summary = "Error al ingresar un piloto",
                                            value = "{\"message\": \"El piloto 'col' debe ser ingresado en mayúsculas.\", \"path\": \"uri=/api/f1/{memberGroupId}/{raceId}/newPrediction\"}"
                                    ),
                                    @ExampleObject(
                                            name = "400 Response",
                                            summary = "Error al ingresar un piloto",
                                            value = "{\"message\": \"No se pueden repetir los pilotos.\", \"path\": \"uri=/api/f1/{memberGroupId}/{raceId}/newPrediction\"}"
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
    @PostMapping("/races/{raceId}/results")
    @CircuitBreaker(name = "f1Service", fallbackMethod = "uploadResultsFallback")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> uploadF1RaceResult(@PathVariable Long raceId, @RequestBody @Valid RaceResultRequestDTO raceResult){
        try {
            raceService.uploadRaceResults(raceId, raceResult);
            return ResponseEntity.status(HttpStatus.CREATED).body("successfully");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    private ResponseEntity<?> uploadResultsFallback(@PathVariable Long raceId, @RequestBody @Valid RaceResultRequestDTO raceResult) {
        return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE).build();
    }
}
