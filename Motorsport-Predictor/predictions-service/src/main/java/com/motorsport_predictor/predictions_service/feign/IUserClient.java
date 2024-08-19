package com.motorsport_predictor.predictions_service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "users-service")
public interface IUserClient {
    @GetMapping("/getLoggedUser")
    String getLoggedInUserId();
}
