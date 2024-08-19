package com.motorsport_predictor.predictions_service.feign;

import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(name = "f1-service")
public interface IF1Client {
}
