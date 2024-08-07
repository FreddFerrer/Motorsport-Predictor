package com.motorsport_predictor.users_service.service.impl;

import com.motorsport_predictor.users_service.dto.CreateGroupDTO;
import com.motorsport_predictor.users_service.models.entities.Group;
import com.motorsport_predictor.users_service.models.repositories.IGroupRepository;
import com.motorsport_predictor.users_service.service.IGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class GroupServiceImpl implements IGroupService {

    @Autowired
    private IGroupRepository groupRepository;

    @Override
    public List<Group> getAllGroups() {
        return groupRepository.findAll();
    }

    @Override
    public Group getGroupById(Long id) {
        return groupRepository.findById(id).orElse(null);
    }

    @Override
    public Optional<Group> getGroupByName(String name) {
        return groupRepository.findByName(name);
    }

    @Override
    public Optional<Group> getGroupByDiscipline(String discipline) {
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
                .build();

        return groupRepository.save(group);
    }

    @Override
    public void deleteGroupById(Long groupId) {
    }
}
