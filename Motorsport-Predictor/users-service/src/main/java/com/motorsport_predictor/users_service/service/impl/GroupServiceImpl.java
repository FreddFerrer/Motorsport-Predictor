package com.motorsport_predictor.users_service.service.impl;

import com.motorsport_predictor.users_service.dto.CreateGroupDTO;
import com.motorsport_predictor.users_service.models.entities.Group;
import com.motorsport_predictor.users_service.models.repositories.IGroupRepository;
import com.motorsport_predictor.users_service.service.IGroupService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class GroupServiceImpl implements IGroupService {

    private final IGroupRepository groupRepository;

    @Override
    public List<Group> getAllGroups() {
        return groupRepository.findAll();
    }

    @Override
    public Group getGroupById(Long id) {
        return groupRepository.getReferenceById(id);
    }

    @Override
    public Group getGroupByName(String name) {
        return groupRepository.findByName(name);
    }

    @Override
    public Group getGroupByDiscipline(String discipline) {
        return groupRepository.findByDiscipline(discipline);
    }

    @Override
    public Group createNewGroup(CreateGroupDTO createGroupDTO) {

        String userId = UserServiceImpl.getLoggedInUserId();

        Group group = Group.builder()
                .name(createGroupDTO.getName())
                .description(createGroupDTO.getDescription())
                .isPublic(createGroupDTO.isPublic())
                .isOfficial(false)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .creatorId(userId)
                .discipline(createGroupDTO.getDiscipline())
                .members(new ArrayList<>())
                .build();


        return groupRepository.save(group);

    }

    @Override
    public Group deleteGroupById(Long groupId) {
        return null;
    }
}
