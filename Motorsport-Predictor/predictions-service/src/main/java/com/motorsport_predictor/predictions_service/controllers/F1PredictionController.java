package com.motorsport_predictor.predictions_service.controllers;

import com.motorsport_predictor.predictions_service.dto.request.PredictionsRequestDTO;
import com.motorsport_predictor.predictions_service.exceptions.BadRequestException;
import com.motorsport_predictor.predictions_service.feign.IF1Client;
import com.motorsport_predictor.predictions_service.feign.IUserClient;
import com.motorsport_predictor.predictions_service.services.IF1PredictionService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/predictions")
@CrossOrigin
@AllArgsConstructor
public class F1PredictionController {

    private final IF1PredictionService predictionService;

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
