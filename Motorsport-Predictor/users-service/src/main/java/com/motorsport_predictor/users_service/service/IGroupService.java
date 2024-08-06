package com.motorsport_predictor.users_service.service;

import com.motorsport_predictor.users_service.dto.CreateGroupDTO;
import com.motorsport_predictor.users_service.models.entities.Group;

import java.util.List;

public interface IGroupService {
    List<Group> getAllGroups();
    Group getGroupById(Long groupId);
    Group getGroupByName(String groupName);
    Group getGroupByDiscipline(String groupDiscipline);
    Group createNewGroup(CreateGroupDTO createGroup);
    Group deleteGroupById(Long groupId);
}
