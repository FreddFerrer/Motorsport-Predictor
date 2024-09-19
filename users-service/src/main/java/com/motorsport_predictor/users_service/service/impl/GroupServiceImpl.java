package com.motorsport_predictor.users_service.service.impl;

import com.motorsport_predictor.users_service.dto.request.CreateGroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.exceptions.ResourceNotFoundException;
import com.motorsport_predictor.users_service.models.entities.Group;
import com.motorsport_predictor.users_service.models.entities.GroupMember;
import com.motorsport_predictor.users_service.models.repositories.IGroupMemberRepository;
import com.motorsport_predictor.users_service.models.repositories.IGroupRepository;
import com.motorsport_predictor.users_service.service.IGroupService;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GroupServiceImpl implements IGroupService {
    private final IGroupRepository groupRepository;
    private final IGroupMemberRepository groupMemberRepository;

    @Override
    public Page<GroupDTO> getAllGroups(Pageable pageable) {
        Page<Group> groups = groupRepository.findAll(pageable);

        return groups.map(group -> GroupDTO.builder()
                        .name(group.getName())
                        .description(group.getDescription())
                        .isPublic(group.isPublic())
                        .createdAt(group.getCreatedAt())
                        .updatedAt(group.getUpdatedAt())
                        .creatorId(group.getCreatorId())
                        .memberCount(group.getMemberCount())
                        .isOfficial(group.isOfficial())
                        .discipline(group.getDiscipline())
                        .build());
    }

    @Override
    public Optional<GroupDTO> getGroupById(Long id) {

        Optional<Group> groupFound = groupRepository.findById(id);

        if (groupFound.isEmpty()) {
            throw new ResourceNotFoundException("group " + id);
        }

        return groupRepository.findById(id)
                .map(group -> GroupDTO.builder()
                        .name(group.getName())
                        .description(group.getDescription())
                        .isPublic(group.isPublic())
                        .createdAt(group.getCreatedAt())
                        .updatedAt(group.getUpdatedAt())
                        .creatorId(group.getCreatorId())
                        .memberCount(group.getMemberCount())
                        .isOfficial(group.isOfficial())
                        .discipline(group.getDiscipline())
                        .build());
    }

    @Override
    public Optional<GroupDTO> getGroupByName(String name) {
        Optional<Group> groupFound = groupRepository.findByName(name);

        if (groupFound.isEmpty()) {
            throw new ResourceNotFoundException("group " + name);
        }

        return groupFound.map(group -> GroupDTO.builder()
                        .name(group.getName())
                        .description(group.getDescription())
                        .isPublic(group.isPublic())
                        .createdAt(group.getCreatedAt())
                        .updatedAt(group.getUpdatedAt())
                        .creatorId(group.getCreatorId())
                        .memberCount(group.getMemberCount())
                        .isOfficial(group.isOfficial())
                        .discipline(group.getDiscipline())
                        .build());
    }

    @Override
    public Page<GroupDTO> getGroupsByDiscipline(String discipline, Pageable pageable) {
        Page<Group> groups = groupRepository.findByDiscipline(discipline, pageable);

        if (groups.isEmpty()) {
            throw new ResourceNotFoundException(discipline);
        }

        return groups.map(group -> GroupDTO.builder()
                        .name(group.getName())
                        .description(group.getDescription())
                        .isPublic(group.isPublic())
                        .createdAt(group.getCreatedAt())
                        .updatedAt(group.getUpdatedAt())
                        .creatorId(group.getCreatorId())
                        .memberCount(group.getMemberCount())
                        .isOfficial(group.isOfficial())
                        .discipline(group.getDiscipline())
                        .build());
    }

    @Override
    public List<GroupDTO> getPopularGroups() {
        // Get groups order by 'member_count' decreasing
        List<Group> popularGroups = groupRepository.findTop10ByOrderByMemberCountDesc();

        // Mapping
        return popularGroups.stream()
                .map(group -> {
                    GroupDTO dto = new GroupDTO();
                    dto.setName(group.getName());
                    dto.setDescription(group.getDescription());
                    dto.setPublic(group.isPublic());
                    dto.setDiscipline(group.getDiscipline());
                    dto.setCreatedAt(group.getCreatedAt());
                    dto.setMemberCount(group.getMemberCount());
                    dto.setCreatorId(group.getCreatorId());
                    dto.setOfficial(group.isOfficial());
                    return dto;
                })
                .collect(Collectors.toList());
    }

    // Get groups by NAME or DESCRIPTION
    @Override
    public Page<GroupDTO> searchGroups(String searchTerm, Pageable pageable) {
        Page<Group> groups = groupRepository.searchGroups(searchTerm, pageable);

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
    public GroupDTO createNewGroup(CreateGroupDTO createGroupDTO) {
        String userId = UserServiceImpl.getLoggedUserId();

        // Get user role
        Collection<? extends GrantedAuthority> roles = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
        boolean isAdmin = roles.stream().anyMatch(role -> role.getAuthority().equals("ROLE_ADMIN"));

        Group group = Group.builder()
                .name(createGroupDTO.getName())
                .description(createGroupDTO.getDescription())
                .isPublic(createGroupDTO.isPublic())
                .isOfficial(isAdmin)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .creatorId(userId)
                .memberCount(0)
                .discipline(createGroupDTO.getDiscipline())
                .build();

        groupRepository.save(group);

        // Add the creator user to the new group
        GroupMember groupMember = new GroupMember();
        groupMember.setGroup(group);
        groupMember.setUserId(userId);
        groupMember.setJoinedAt(LocalDateTime.now());

        try {
            groupMemberRepository.save(groupMember);
        } catch (DataIntegrityViolationException e) {
            // Unicidad error handler
            throw new DataIntegrityViolationException("Error saving group");
        }

        return GroupDTO.builder()
                .name(group.getName())
                .discipline(group.getDiscipline())
                .description(group.getDescription())
                .isPublic(group.isPublic())
                .createdAt(group.getCreatedAt())
                .updatedAt(group.getUpdatedAt())
                .creatorId(group.getCreatorId())
                .isOfficial(group.isOfficial())
                .build();
    }

    @Override
    public void updateGroup(Long groupId, CreateGroupDTO createGroup) {

    }

    @Override
    public void deleteGroupById(Long groupId) {
        // Get logged user id
        String loggedInUserId = UserServiceImpl.getLoggedUserId();

        // Check if group Id exist
        Group group = groupRepository.findById(groupId)
                .orElseThrow(() -> new ResourceNotFoundException("Group with ID " + groupId + " not found"));

        // Check if logged user is the creator of the group
        if (!group.getCreatorId().equals(loggedInUserId)) {
            throw new BadRequestException("Only the creator of the group can delete the group.");
        }

        groupRepository.deleteById(groupId);

    }
}
