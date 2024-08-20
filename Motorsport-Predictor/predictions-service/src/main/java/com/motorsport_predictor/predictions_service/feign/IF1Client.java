package com.motorsport_predictor.predictions_service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.cloud.openfeign.FeignClientProperties;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(value = "f1-service", configuration = FeignClientProperties.FeignClientConfiguration.class)
public interface IF1Client {
    @GetMapping("/api/f1/drivers/{driverId}/exists")
    boolean existsById(@PathVariable Long driverId);
    @GetMapping("/races/{raceId}/exist")
    boolean existsRacesById(@PathVariable Long raceId);
}
