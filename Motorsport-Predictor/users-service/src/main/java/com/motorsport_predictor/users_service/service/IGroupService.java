package com.motorsport_predictor.users_service.service;

import com.motorsport_predictor.users_service.dto.request.CreateGroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupDTO;

import java.util.List;
import java.util.Optional;

public interface IGroupService {
    List<GroupDTO> getAllGroups();
    Optional<GroupDTO> getGroupById(Long groupId);
    Optional<GroupDTO> getGroupByName(String groupName);
    List<GroupDTO> getGroupsByDiscipline(String groupDiscipline);
    List<GroupDTO> getPopularGroups(); // Obtener grupos populares (por ejemplo, más miembros)
    List<GroupDTO> searchGroups(String searchTerm); // Buscar grupos por nombre o descripción
    List<GroupDTO> getGroupsByUserId(String userId); // Obtener grupos de un usuario
    GroupDTO createNewGroup(CreateGroupDTO createGroup);
    void updateGroup(Long groupId, CreateGroupDTO createGroup);
    void deleteGroupById(Long groupId);
}
