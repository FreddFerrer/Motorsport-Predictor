package com.motorsport_predictor.f1_service.controllers;

import com.motorsport_predictor.f1_service.dto.CircuitDTO;
import com.motorsport_predictor.f1_service.dto.DriverDTO;
import com.motorsport_predictor.f1_service.dto.RaceDTO;
import com.motorsport_predictor.f1_service.dto.request.RaceResultRequestDTO;
import com.motorsport_predictor.f1_service.exceptions.BadRequestException;
import com.motorsport_predictor.f1_service.services.ICircuitService;
import com.motorsport_predictor.f1_service.services.IDriverService;
import com.motorsport_predictor.f1_service.services.IRaceService;
import io.swagger.v3.oas.annotations.Hidden;
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

    @Operation(
            summary = "Obtener todos los pilotos",
            description = "Devuelve una lista paginada de los pilotos de Fórmula 1. Es un endpoint protegido que requiere autenticación y autorización (roles: ADMIN o USER).",
            security = @SecurityRequirement(name = "bearerAuth")
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
                                            value = "{\"message\": \"No hay registros de raceId 67 en el sistema\", \"path\": \"\"uri=/api/f1/races/67\"\"}"
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
                                            value = "{\"timestamp\": \"2024-09-05T12:34:56.789\", \"message\": \"Race not found\"}"
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
                                            value = "{\"timestamp\": \"2024-09-05T12:34:56.789\", \"message\": \"Invalid request format\"}"
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
            summary = "Cargar los resultados de una carrera de Fórmula 1",
            description = "Este endpoint permite a un administrador cargar los resultados de una carrera de Fórmula 1, incluyendo las posiciones de los pilotos.",
            security = @SecurityRequirement(name = "bearerAuth")
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
                                            summary = "Error en la solicitud",
                                            value = "{\"timestamp\": \"2024-09-05T12:34:56.789\", \"message\": \"El piloto con ID 5 no existe.\"}"
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
                                            value = "{\"timestamp\": \"2024-09-05T12:34:56.789\", \"message\": \"Access is denied\"}"
                                    )
                            }
                    )
            )
    })
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
