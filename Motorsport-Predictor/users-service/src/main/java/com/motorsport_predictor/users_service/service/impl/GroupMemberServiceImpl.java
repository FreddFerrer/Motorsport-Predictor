package com.motorsport_predictor.users_service.service.impl;

import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupMemberDTO;
import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.exceptions.ResourceNotFoundException;
import com.motorsport_predictor.users_service.models.entities.Group;
import com.motorsport_predictor.users_service.models.entities.GroupMember;
import com.motorsport_predictor.users_service.models.repositories.IGroupMemberRepository;
import com.motorsport_predictor.users_service.models.repositories.IGroupRepository;
import com.motorsport_predictor.users_service.service.IGroupMemberService;
import com.motorsport_predictor.users_service.util.KeycloakProvider;
import lombok.RequiredArgsConstructor;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GroupMemberServiceImpl implements IGroupMemberService {
    private final IGroupMemberRepository groupMemberRepository;
    private final IGroupRepository groupRepository;

    @Override
    public Page<GroupMemberDTO> getMembersByGroupId(Long groupId, Pageable pageable) {
        // Check if group exists
        groupRepository.findById(groupId)
                .orElseThrow(() -> new ResourceNotFoundException("Group with ID " + groupId + " not found"));

        // Get members id's and his joined dates
        Page<Object[]> membersPage = groupMemberRepository.findUserIdAndJoinedAtByGroupId(groupId, pageable);

        // Separate user id's
        List<String> memberIds = membersPage.stream()
                .map(member -> (String) member[0])
                .collect(Collectors.toList());

        // Get from keycloak the list of users that correspond to that id
        List<UserRepresentation> keycloakUsers = KeycloakProvider.getUsersByIds(memberIds);

        // Create a user id map to UserRepresentation for quick access
        Map<String, UserRepresentation> userMap = keycloakUsers.stream()
                .collect(Collectors.toMap(UserRepresentation::getId, Function.identity()));

        // mapping
        List<GroupMemberDTO> memberDTOs = membersPage.getContent().stream()
                .map(member -> {
                    String userId = (String) member[0];
                    LocalDateTime joinedAt = (LocalDateTime) member[1];
                    UserRepresentation user = userMap.get(userId);

                    GroupMemberDTO dto = new GroupMemberDTO();
                    dto.setUserId(userId);
                    dto.setUsername(user.getUsername());
                    dto.setJoinedAt(joinedAt);

                    // Obtener la nacionalidad del atributo personalizado
                    String nationality = user.getAttributes() != null && user.getAttributes().get("nationality") != null ?
                            user.getAttributes().get("nationality").get(0) : "Unknown";

                    dto.setNationality(nationality);
                    return dto;
                })
                .collect(Collectors.toList());

        return new PageImpl<>(memberDTOs, pageable, membersPage.getTotalElements());
    }

    @Override
    public Page<GroupDTO> getGroupsByUserId(String userId, Pageable pageable) {
        // Get user by id and check if exists
        UserRepresentation user = KeycloakProvider.getUserById(userId);

        // Obtain all the IDs of the groups to which this user is related
        // (a user can be in many groups, but never can be in the same group twice).
        List<Long> groupIds = groupMemberRepository.findGroupIdsByUserId(userId);
        if (groupIds.isEmpty()) {
            return Page.empty(); // Return empty page if it not has any group
        }

        // Consult data of the groups taking into consideration the previously obtained ids.
        Page<Group> groupsPage = groupRepository.findByIdIn(groupIds, pageable);

        // Mapping
        Page<GroupDTO> groupDTOs = groupsPage.map(group -> GroupDTO.builder()
                .name(group.getName())
                .description(group.getDescription())
                .isPublic(group.isPublic())
                .discipline(group.getDiscipline())
                .createdAt(group.getCreatedAt())
                .creatorId(group.getCreatorId())
                .isOfficial(group.isOfficial())
                .memberCount(group.getMemberCount())
                .build());

        return groupDTOs;
    }

    @Override
    public Page<GroupDTO> getGroupsByUser(Pageable pageable) {
        String userId = UserServiceImpl.getLoggedUserId();
        return getGroupsByUserId (userId, pageable);
    }

    @Override
    public Page<GroupDTO> getGroupsByUsername(String username, Pageable pageable) {
        // Get user id from username
        UserRepresentation user = KeycloakProvider.getUserByUsername(username);
        String userId = user.getId();

        // Obtain all the IDs of the groups to which this user is related
        // (a user can be in many groups, but never can be in the same group twice).
        List<Long> groupIds = groupMemberRepository.findGroupIdsByUserId(userId);
        if (groupIds.isEmpty()) {
            return Page.empty(); // Return empty page if it not has any group
        }

        // Consult data of the groups taking into consideration the previously obtained ids.
        Page<Group> groups = groupRepository.findByIdIn(groupIds, pageable);

        // Mapping
        return groups.map(group -> {
                    GroupDTO dto = new GroupDTO();
                    dto.setName(group.getName());
                    dto.setDescription(group.getDescription());
                    dto.setPublic(group.isPublic());
                    dto.setDiscipline(group.getDiscipline());
                    dto.setCreatedAt(group.getCreatedAt());
                    dto.setCreatorId(group.getCreatorId());
                    dto.setOfficial(group.isOfficial());
                    return dto;
                });
    }

    @Override
    public void addMemberToGroupById(Long groupId, String userId) {
        UserRepresentation user = KeycloakProvider.getUserById(userId);

        // Get logged user id
        String loggedInUserId = UserServiceImpl.getLoggedUserId();

        // Check if group Id exist
        Group group = groupRepository.findById(groupId)
                .orElseThrow(() -> new ResourceNotFoundException("Group with ID " + groupId + " not found"));

        // Check if logged user is the creator of the group
        if (!group.getCreatorId().equals(loggedInUserId)) {
            throw new BadRequestException("Only the creator of the group can add members.");
        }

        // Avoid user self-adding
        if (loggedInUserId.equals(userId)) {
            throw new BadRequestException("You cannot add yourself to the group.");
        }

        // Check if the user is already a member of the group
        if (groupMemberRepository.existsByGroupAndUserId(group, userId)) {
            throw new BadRequestException("User is already a member of the group.");
        }

        // Add member
        GroupMember groupMember = new GroupMember();
        groupMember.setGroup(group);
        groupMember.setUserId(user.getId());
        groupMember.setJoinedAt(LocalDateTime.now());

        try {
            groupMemberRepository.save(groupMember);
        } catch (DataIntegrityViolationException e) {
            // Unicidad error handler
            throw new DataIntegrityViolationException("Error saving group");
        }
    }

    @Override
    public void addMemberToGroupByUsername(Long groupId, String username) {
        Group group;

        UserRepresentation user = KeycloakProvider.getUserByUsername(username);

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
            throw new DataIntegrityViolationException("Error saving group");
        }
    }

    @Override
    public void removeMemberFromGroupById(Long groupId, String userId) {
        Group group;

        UserRepresentation user = KeycloakProvider.getUserById(userId);

        // Check if group id exists
        if (!groupRepository.existsById(groupId)) {
            throw new ResourceNotFoundException("groupId " + groupId);
        } else {
            group = groupRepository.getReferenceById(groupId);
        }

        // Take corrects ids
        Long groupIdObtained = group.getId();
        String userIdObtained = user.getId();

        // Check if the user is a member of the group
        GroupMember groupMember = groupMemberRepository.findByGroupIdAndUserId(groupIdObtained, userIdObtained)
                .orElseThrow(() -> new ResourceNotFoundException("User " + userId + " is not a member of group " + groupId));

        // Delete group member
        groupMemberRepository.delete(groupMember);
    }

    @Override
    public boolean isUserInGroup(Long groupId, String userId) {
        return groupMemberRepository.existsByUserIdAndGroupMembersId(userId, groupId);
    }
}
