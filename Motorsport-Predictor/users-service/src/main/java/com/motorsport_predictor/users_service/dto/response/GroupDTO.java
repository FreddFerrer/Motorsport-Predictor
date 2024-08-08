package com.motorsport_predictor.users_service.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class GroupDTO {
    private String name;
    private String description;
    @JsonProperty("isPublic")
    private boolean isPublic;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String creatorId;
    private boolean isOfficial;
    private String discipline;
}