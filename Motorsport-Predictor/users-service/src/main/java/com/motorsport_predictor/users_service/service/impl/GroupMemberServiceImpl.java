package com.motorsport_predictor.users_service.service.impl;

import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupMemberDTO;
import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.exceptions.CustomErrorResponse;
import com.motorsport_predictor.users_service.exceptions.ResourceNotFoundException;
import com.motorsport_predictor.users_service.models.entities.Group;
import com.motorsport_predictor.users_service.models.entities.GroupMember;
import com.motorsport_predictor.users_service.models.repositories.IGroupMemberRepository;
import com.motorsport_predictor.users_service.models.repositories.IGroupRepository;
import com.motorsport_predictor.users_service.service.IGroupMemberService;
import com.motorsport_predictor.users_service.util.KeycloakProvider;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class GroupMemberServiceImpl implements IGroupMemberService {

    @Autowired
    private IGroupMemberRepository groupMemberRepository;
    @Autowired
    private IGroupRepository groupRepository;

    @Override
    public void addMemberToGroupById(Long groupId, String userId) {
        Group group;
        UserResource user;

        //Busca el usuario por el ID
        try {
            user = KeycloakProvider.getUserResource()
                    .get(userId);
        } catch (Exception e) {
            throw new ResourceNotFoundException("userId " + userId);
        }

        System.out.println("EL ID ESSSSSSSSSSSS:" + user);

        if (!groupRepository.existsById(groupId)) {
            throw new ResourceNotFoundException("groupId" + groupId);
        } else {
            group = groupRepository.getReferenceById(groupId);
        }

        GroupMember groupMember = new GroupMember();
        groupMember.setGroup(group);
        groupMember.setUserId(user.toRepresentation().getId());
        groupMember.setJoinedAt(LocalDateTime.now());

        try {
            groupMemberRepository.save(groupMember);
        } catch (DataIntegrityViolationException e) {
            // Manejar error de restricción de unicidad
            throw new DataIntegrityViolationException("Error saving group");
        }
    }

    @Override
    public void addMemberToGroupByUsername(Long groupId, String username) {
        Group group;

        List<UserRepresentation> users = KeycloakProvider.getUserResource().search(username);

        // Verifica si el usuario existe
        if (users == null || users.isEmpty()) {
            throw new ResourceNotFoundException("username: " + username);
        }

        // Se asume que el username es único y se toma el primer resultado
        UserRepresentation user = users.get(0);

        if (!groupRepository.existsById(groupId)) {
            throw new ResourceNotFoundException("groupId" + groupId);
        } else {
            group = groupRepository.getReferenceById(groupId);
        }

        GroupMember groupMember = new GroupMember();
        groupMember.setGroup(group);
        groupMember.setUserId(user.getId());
        groupMember.setJoinedAt(LocalDateTime.now());

        try {
            groupMemberRepository.save(groupMember);
        } catch (DataIntegrityViolationException e) {
            // Manejar error de restricción de unicidad
            throw new DataIntegrityViolationException("Error saving group");
        }
    }

    @Override
    public void removeMemberFromGroupById(Long groupId, String userId) {

    }

    @Override
    public List<GroupMemberDTO> getMembersByGroupId(Long groupId) {
        return null;
    }

    @Override
    public List<GroupDTO> getGroupsByUserId(String userId) {
        return null;
    }

    @Override
    public List<GroupDTO> getGroupsByUsername(String username) {
        return null;
    }

}
