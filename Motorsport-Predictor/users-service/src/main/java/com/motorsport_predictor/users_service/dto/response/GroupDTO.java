package com.motorsport_predictor.users_service.dto.response;

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
    private String description;
    private String discipline;
    @JsonProperty("isPublic")
    private boolean isPublic;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String creatorId;
    private boolean isOfficial;



    public GroupDTO(Long id, String name, String description) {
    }
}