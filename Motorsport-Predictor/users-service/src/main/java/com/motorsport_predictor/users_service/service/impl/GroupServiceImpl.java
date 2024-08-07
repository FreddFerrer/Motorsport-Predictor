package com.motorsport_predictor.users_service.service.impl;

import com.motorsport_predictor.users_service.dto.CreateGroupDTO;
import com.motorsport_predictor.users_service.models.entities.Groups;
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
    public List<Groups> getAllGroups() {
        return groupRepository.findAll();
    }

    @Override
    public Groups getGroupById(Long id) {
        return groupRepository.findById(id).orElse(null);
    }

    @Override
    public Optional<Groups> getGroupByName(String name) {
        return groupRepository.findByName(name);
    }

    @Override
    public Optional<Groups> getGroupByDiscipline(String discipline) {
        return groupRepository.findByDiscipline(discipline);
    }

    @Override
    public Groups createNewGroup(CreateGroupDTO createGroupDTO) {

        String userId = UserServiceImpl.getLoggedInUserId();

        Groups group = new Groups();
        group.setName(createGroupDTO.getName());
        group.setDescription(createGroupDTO.getDescription());
        group.setPublic(createGroupDTO.isPublic());
        group.setOfficial(false);
        group.setCreatedAt(LocalDateTime.now());
        group.setUpdatedAt(LocalDateTime.now());
        group.setCreatorId(userId);
        group.setDiscipline(createGroupDTO.getDiscipline());

        System.out.println("EL NAME ES " + group.getName());
        System.out.println("LA DESCR ES " + group.getDescription());
        System.out.println("PUBLICO " + group.isPublic());
        System.out.println("CREADOR " + group.getCreatorId());
        System.out.println("CREADO " + group.getCreatedAt());

        return groupRepository.save(group);

    }

    @Override
    public void deleteGroupById(Long groupId) {
    }
}
