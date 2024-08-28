package com.motorsport_predictor.f1_service.feign;

import com.motorsport_predictor.f1_service.dto.RaceResultDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@FeignClient(name = "predictions-service")
public interface IPredictionsClient {
    @PostMapping("/api/predictions/upload-results/{raceId}")
    void sendRaceResults(@PathVariable Long raceId, @RequestBody List<RaceResultDTO> results);
}
