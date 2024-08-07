package com.motorsport_predictor.users_service.service;

import com.motorsport_predictor.users_service.dto.CreateGroupDTO;
import com.motorsport_predictor.users_service.models.entities.Groups;

import java.util.List;
import java.util.Optional;

public interface IGroupService {
    List<Groups> getAllGroups();
    Groups getGroupById(Long groupId);
    Optional<Groups> getGroupByName(String groupName);
    Optional<Groups> getGroupByDiscipline(String groupDiscipline);
    Groups createNewGroup(CreateGroupDTO createGroup);
    void deleteGroupById(Long groupId);
}
