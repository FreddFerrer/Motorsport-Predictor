package com.motorsport_predictor.users_service.service;

import com.motorsport_predictor.users_service.dto.request.CreateGroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface IGroupService {
    Page<GroupDTO> getAllGroups(Pageable pageable);
    Optional<GroupDTO> getGroupById(Long groupId);
    Optional<GroupDTO> getGroupByName(String groupName);
    Page<GroupDTO> getGroupsByDiscipline(String groupDiscipline, Pageable pageable);
    List<GroupDTO> getPopularGroups();
    Page<GroupDTO> searchGroups(String searchTerm, Pageable pageable); // Buscar grupos por nombre o descripción
    GroupDTO createNewGroup(CreateGroupDTO createGroup);
    void updateGroup(Long groupId, CreateGroupDTO createGroup);
    void deleteGroupById(Long groupId);
}
