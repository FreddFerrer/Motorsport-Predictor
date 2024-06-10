package com.fredd.motorsport_predictor.controllers;

import com.fredd.motorsport_predictor.dto.PredictionGroupDto;
import com.fredd.motorsport_predictor.service.IPredictionGroupService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/")
@RequiredArgsConstructor
public class PredictionGroupController {

    private final IPredictionGroupService iPredictionGroupService;

    @GetMapping()
    public ResponseEntity<List<PredictionGroupDto>> getAll() {
        return ResponseEntity.ok(iPredictionGroupService.getAllPredictionGroup());
    }

    @GetMapping(path = "/{id}")
    public ResponseEntity<PredictionGroupDto> getPredictionGroupById(@PathVariable Long id){
        return ResponseEntity.of(iPredictionGroupService.getPredictionGroupById(id));
    }

    @GetMapping(path = "/usuario/{groupName}")
    public ResponseEntity<PredictionGroupDto> getPredictionGroupByUserCreator(@PathVariable String userCreator) {
        return ResponseEntity.of(iPredictionGroupService.getPredictionGroupByUser(userCreator));
    }

//    @PostMapping()
//    public ResponseEntity<PredictionGroupResponseDto> save(@RequestBody PredictionGroupDto predictionGroupDto) {
//        return ResponseEntity.status(HttpStatus.CREATED)
//                .body(iPredictionGroupService.savePredictionGroup(predictionGroupDto));
//    }

    @Pat

}
