package com.motorsport_predictor.predictions_service.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.cloud.openfeign.FeignClientProperties;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(value = "users-service", configuration = FeignClientProperties.FeignClientConfiguration.class)
public interface IUserClient {
    @GetMapping("/api/users/getLoggedUser")
    String getLoggedInUserId();
    @GetMapping("/api/groups/existUserInGroup/{groupId}/{userId}")
    boolean existUserInGroup(@PathVariable Long groupId, @PathVariable String userId);
}
