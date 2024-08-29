package com.motorsport_predictor.f1_service.feign;

import com.motorsport_predictor.f1_service.dto.request.RaceResultRequestDTO;
import jakarta.validation.Valid;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@FeignClient(name = "predictions-service")
public interface IPredictionsClient {
    @PostMapping("/api/predictions/f1/upload-results/{raceId}")
    void sendRaceResults(@PathVariable Long raceId, @RequestBody @Valid RaceResultRequestDTO results);
}
