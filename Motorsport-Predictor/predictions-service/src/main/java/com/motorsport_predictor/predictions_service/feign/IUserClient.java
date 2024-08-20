package com.motorsport_predictor.predictions_service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "users-service")
public interface IUserClient {
    @GetMapping("/getLoggedUser")
    String getLoggedInUserId();
    @GetMapping("/existUserInGroup/{groupId}/{userId}")
    boolean existUserInGroup(@PathVariable Long groupId, @PathVariable String userId);
}
