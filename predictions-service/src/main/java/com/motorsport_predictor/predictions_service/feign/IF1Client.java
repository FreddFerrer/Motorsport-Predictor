package com.motorsport_predictor.predictions_service.feign;

import com.motorsport_predictor.predictions_service.config.FeignConfig;
import com.motorsport_predictor.predictions_service.dto.RaceDTO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@FeignClient(name = "f1-service", url = "http://f1-service:8083", configuration = FeignConfig.class)
public interface IF1Client {
    @GetMapping("/api/f1/drivers/id")
    Long getDriverIdByShortname(@RequestParam String shortname);
    @GetMapping("/api/f1/races/{raceId}/exist")
    boolean existsRacesById(@PathVariable Long raceId);
    @GetMapping("api/f1/races/{raceId}")
    RaceDTO getRaceInfo(@PathVariable Long raceId);
}