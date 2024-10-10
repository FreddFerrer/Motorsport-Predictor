package com.motorsport_predictor.predictions_service.feign;

import com.motorsport_predictor.predictions_service.config.FeignConfig;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "users-service", url = "http://users-service:8081", configuration = FeignConfig.class)
public interface IUserClient {
    @GetMapping("/api/users/loggedUser")
    String getLoggedInUserId();
    @GetMapping("/api/groups/existUserInGroup/{groupId}/{userId}")
    boolean existUserInGroup(@PathVariable Long groupId, @PathVariable String userId);
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    @GetMapping("/api/users/email")
    String getUserEmail();
}