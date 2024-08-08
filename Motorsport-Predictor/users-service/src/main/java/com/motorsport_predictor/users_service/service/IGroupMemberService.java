package com.motorsport_predictor.users_service.service;

import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupMemberDTO;

import java.util.List;

public interface IGroupMemberService {
    void addMemberToGroupById(Long groupId, String userId);
    void addMemberToGroupByUsername(Long groupId, String username);
    void removeMemberFromGroupById(Long groupId, String userId);
    List<GroupMemberDTO> getMembersByGroupId(Long groupId);
    List<GroupDTO> getGroupsByUserId(String userId);
    List<GroupDTO> getGroupsByUsername(String username);


    // Acciones del usuario final
    //void requestToJoinGroup(Long groupId);
    //void leaveGroup(Long groupId);
    //void sendMessage(Long groupId, String message);
}