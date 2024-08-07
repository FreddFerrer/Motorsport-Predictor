package com.motorsport_predictor.users_service.service;

import com.motorsport_predictor.users_service.dto.CreateGroupDTO;
import com.motorsport_predictor.users_service.models.entities.Group;

import java.util.List;
import java.util.Optional;

public interface IGroupService {
    List<Group> getAllGroups();
    Group getGroupById(Long groupId);
    Optional<Group> getGroupByName(String groupName);
    Optional<Group> getGroupByDiscipline(String groupDiscipline);
    Group createNewGroup(CreateGroupDTO createGroup);
    void deleteGroupById(Long groupId);
}
