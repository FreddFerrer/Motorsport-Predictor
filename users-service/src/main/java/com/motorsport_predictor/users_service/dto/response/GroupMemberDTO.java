package com.motorsport_predictor.users_service.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GroupMemberDTO {
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private List<GroupDTO> group;
    private String userId;
    private String username;
    private String nationality;
    private LocalDateTime joinedAt;
}
