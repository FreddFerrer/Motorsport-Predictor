package com.motorsport_predictor.predictions_service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(value = "users-service")
public interface IUserClient {
    @GetMapping("/api/users/loggedUser")
    String getLoggedInUserId();
    @GetMapping("/api/groups/existUserInGroup/{groupId}/{userId}")
    boolean existUserInGroup(@PathVariable Long groupId, @PathVariable String userId);
    @GetMapping("/api/users/email")
    String getUserEmail();
}