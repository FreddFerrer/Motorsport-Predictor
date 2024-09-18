package com.motorsport_predictor.predictions_service.feign;

import com.motorsport_predictor.predictions_service.dto.RaceDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(value = "f1-service")
public interface IF1Client {
    @GetMapping("/api/f1/drivers/{driverId}/exist")
    boolean existsById(@PathVariable Long driverId);
    @GetMapping("/api/f1/races/{raceId}/exist")
    boolean existsRacesById(@PathVariable Long raceId);
    @GetMapping("api/f1/races/{raceId}")
    RaceDTO getRaceInfo(@PathVariable Long raceId);
}