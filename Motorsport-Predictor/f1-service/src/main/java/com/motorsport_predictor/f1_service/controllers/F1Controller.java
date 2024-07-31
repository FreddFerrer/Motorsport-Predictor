package com.motorsport_predictor.f1_service.controllers;

import com.motorsport_predictor.f1_service.exceptions.BadRequestException;
import com.motorsport_predictor.f1_service.services.ICircuitService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/f1")
@CrossOrigin
@AllArgsConstructor
public class F1Controller {

    private final ICircuitService circuitService;


    @GetMapping("/cicuits")
    public ResponseEntity<?> findAllCircuits(){
        try {
            return ResponseEntity.ok(circuitService.findAllCircuit());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }
}
