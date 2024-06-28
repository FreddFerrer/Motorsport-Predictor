package com.fredd.motorsport_predictor.controllers;


import com.fredd.motorsport_predictor.dto.request.PredictionGroupRequestDto;
import com.fredd.motorsport_predictor.dto.response.PredictionGroupDto;
import com.fredd.motorsport_predictor.exceptions.BadRequestException;
import com.fredd.motorsport_predictor.models.entities.User;
import com.fredd.motorsport_predictor.service.IPredictionGroupService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/")
@RequiredArgsConstructor
public class PredictionGroupController {

    private final IPredictionGroupService iPredictionGroupService;

    @GetMapping("/PredictionGroups")
    public ResponseEntity<?> getAll() {
        try {
            return ResponseEntity.ok(iPredictionGroupService.getAllPredictionGroup());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<PredictionGroupDto> getPredictionGroupById(@PathVariable Long id) {
        try {
            return ResponseEntity.of(iPredictionGroupService.getPredictionGroupById(id));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping(path = "/usuario/{userCreator}")
    public ResponseEntity<PredictionGroupDto> getPredictionGroupByUserCreator(@PathVariable Long userCreator) {
        try {
            return ResponseEntity.of(iPredictionGroupService.getPredictionGroupByUser(userCreator));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @PostMapping("/newPredictionGroup")
    public ResponseEntity<PredictionGroupDto> save(@RequestBody PredictionGroupRequestDto predictionGroupRequestDto) {
        try {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(iPredictionGroupService.savePredictionGroup(predictionGroupRequestDto));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<PredictionGroupDto> edit(@PathVariable Long id, @RequestBody PredictionGroupRequestDto predictionGroupRequestDto) {
        try {
            return ResponseEntity.of(iPredictionGroupService.editPredictionGroup(id, predictionGroupRequestDto));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }
}
