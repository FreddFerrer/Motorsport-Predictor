package com.motorsport_predictor.users_service.service;

import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupMemberDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


public interface IGroupMemberService {
    Page<GroupMemberDTO> getMembersByGroupId(Long groupId, Pageable pageable);
    Page<GroupDTO> getGroupsByUserId(String userId, Pageable pageable);
    Page<GroupDTO> getGroupsByUser(Pageable pageable);
    Page<GroupDTO> getGroupsByUsername(String username,Pageable pageable);
    void addMemberToGroupById(Long groupId, String userId);
    void addMemberToGroupByUsername(Long groupId, String username);
    void removeMemberFromGroupById(Long groupId, String userId);
    boolean isUserInGroup(Long groupId, String userId);

}