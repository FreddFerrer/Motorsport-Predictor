package com.motorsport_predictor.f1_service.controllers;

import com.motorsport_predictor.f1_service.dto.request.RaceResultRequestDTO;
import com.motorsport_predictor.f1_service.exceptions.BadRequestException;
import com.motorsport_predictor.f1_service.services.ICircuitService;
import com.motorsport_predictor.f1_service.services.IDriverService;
import com.motorsport_predictor.f1_service.services.IRaceService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
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
