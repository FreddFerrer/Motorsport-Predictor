package com.motorsport_predictor.users_service.dto.response;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
public class GroupMemberDTO {
    private List<GroupDTO> group;
    private String userId;
    private String username;
    private LocalDateTime joinedAt;
}
