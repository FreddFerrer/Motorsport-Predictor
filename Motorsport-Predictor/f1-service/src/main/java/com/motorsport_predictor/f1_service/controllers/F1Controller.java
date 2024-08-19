package com.motorsport_predictor.f1_service.controllers;

import com.motorsport_predictor.f1_service.exceptions.BadRequestException;
import com.motorsport_predictor.f1_service.models.repositories.IDriverRepository;
import com.motorsport_predictor.f1_service.services.ICircuitService;
import com.motorsport_predictor.f1_service.services.IDriverService;
import com.motorsport_predictor.f1_service.services.IRaceService;
import lombok.AllArgsConstructor;
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
    public ResponseEntity<?> getAllCircuits(){
        try {
            return ResponseEntity.ok(circuitService.getAllCircuit());
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

    @GetMapping("/drivers/{driverId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getDriverById(@PathVariable Long driverId){
        try {
            return ResponseEntity.ok(driverService.existById(driverId));
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

    @GetMapping("/nextRace")
    public ResponseEntity<?> getNextRace(){
        try {
            return ResponseEntity.ok(raceService.getNextRace());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

}
