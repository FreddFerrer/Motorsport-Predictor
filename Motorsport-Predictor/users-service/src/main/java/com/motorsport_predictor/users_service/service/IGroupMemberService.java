package com.motorsport_predictor.users_service.service;

import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupMemberDTO;

import java.util.List;

public interface IGroupMemberService {
    List<GroupMemberDTO> getMembersByGroupId(Long groupId);
    List<GroupDTO> getGroupsByUserId(String userId); // Obtener grupos de un usuario
    List<GroupDTO> getGroupsByUser();
    List<GroupDTO> getGroupsByUsername(String username);
    void addMemberToGroupById(Long groupId, String userId);
    void addMemberToGroupByUsername(Long groupId, String username);
    void removeMemberFromGroupById(Long groupId, String userId);
    boolean isUserInGroup(Long groupId, String userId);

}