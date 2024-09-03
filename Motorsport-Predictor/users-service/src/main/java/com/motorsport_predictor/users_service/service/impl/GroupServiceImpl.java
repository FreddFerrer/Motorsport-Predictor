package com.motorsport_predictor.users_service.service.impl;

import com.motorsport_predictor.users_service.dto.request.CreateGroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.models.entities.Group;
import com.motorsport_predictor.users_service.models.entities.GroupMember;
import com.motorsport_predictor.users_service.models.repositories.IGroupMemberRepository;
import com.motorsport_predictor.users_service.models.repositories.IGroupRepository;
import com.motorsport_predictor.users_service.service.IGroupService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
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
                        .isOfficial(group.isOfficial())
                        .discipline(group.getDiscipline())
                        .build());
    }

    @Override
    public Optional<GroupDTO> getGroupById(Long id) {

        return groupRepository.findById(id)
                .map(group -> GroupDTO.builder()
                        .name(group.getName())
                        .description(group.getDescription())
                        .isPublic(group.isPublic())
                        .createdAt(group.getCreatedAt())
                        .updatedAt(group.getUpdatedAt())
                        .creatorId(group.getCreatorId())
                        .isOfficial(group.isOfficial())
                        .discipline(group.getDiscipline())
                        .build());
    }

    @Override
    public Optional<GroupDTO> getGroupByName(String name) {
        return groupRepository.findByName(name)
                .map(group -> GroupDTO.builder()
                        .name(group.getName())
                        .description(group.getDescription())
                        .isPublic(group.isPublic())
                        .createdAt(group.getCreatedAt())
                        .updatedAt(group.getUpdatedAt())
                        .creatorId(group.getCreatorId())
                        .isOfficial(group.isOfficial())
                        .discipline(group.getDiscipline())
                        .build());
    }

    @Override
    public Page<GroupDTO> getGroupsByDiscipline(String discipline, Pageable pageable) {
        Page<Group> groups = groupRepository.findByDiscipline(discipline, pageable);

        return groups.map(group -> GroupDTO.builder()
                        .name(group.getName())
                        .description(group.getDescription())
                        .isPublic(group.isPublic())
                        .createdAt(group.getCreatedAt())
                        .updatedAt(group.getUpdatedAt())
                        .creatorId(group.getCreatorId())
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

        Group group = Group.builder()
                .name(createGroupDTO.getName())
                .description(createGroupDTO.getDescription())
                .isPublic(createGroupDTO.isPublic())
                .isOfficial(false)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .creatorId(userId)
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
    }
}
