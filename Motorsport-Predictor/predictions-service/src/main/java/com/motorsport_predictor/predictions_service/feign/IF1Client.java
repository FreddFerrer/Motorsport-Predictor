package com.motorsport_predictor.predictions_service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "f1-service")
public interface IF1Client {
    @GetMapping("/drivers/{driverId}/exists")
    boolean existsById(@PathVariable Long driverId);
}
