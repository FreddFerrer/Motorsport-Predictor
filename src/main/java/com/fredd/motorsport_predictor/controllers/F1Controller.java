package com.fredd.motorsport_predictor.controllers;

import com.fredd.motorsport_predictor.exceptions.BadRequestException;
import com.fredd.motorsport_predictor.rest.f1.drivers.F1DriversDto;
import com.fredd.motorsport_predictor.rest.f1.tracks.F1TracksDto;
import com.fredd.motorsport_predictor.service.IF1Service;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api/v1/f1")
@RequiredArgsConstructor
public class F1Controller {

    private final IF1Service if1Service;

    @GetMapping("/drivers/{year}")
    public ResponseEntity<?> getDriversByYear(@PathVariable int year) {
        try {
            F1DriversDto driversByYear = if1Service.getDriversByYear(year);
            return ResponseEntity.ok(driversByYear);
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }


    }

    @GetMapping("/schedule/current")
    public ResponseEntity<?> getCurrentSchedule(){
        try {
            F1TracksDto currentSchedule = if1Service.getCurrentSchedule();
            return ResponseEntity.ok(currentSchedule);
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }
}
