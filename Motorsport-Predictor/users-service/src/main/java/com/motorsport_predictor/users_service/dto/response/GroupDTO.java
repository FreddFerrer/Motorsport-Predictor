package com.motorsport_predictor.users_service.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GroupDTO {
    private String name;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String description;
    private String discipline;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Integer memberCount;
    @JsonProperty("isPublic")
    private boolean isPublic;
    private LocalDateTime createdAt;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private LocalDateTime updatedAt;
    private String creatorId;
    private boolean isOfficial;
}