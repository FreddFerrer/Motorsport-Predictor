package com.motorsport_predictor.users_service.service.impl;

import com.motorsport_predictor.users_service.dto.request.CreateGroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.models.entities.Group;
import com.motorsport_predictor.users_service.models.repositories.IGroupRepository;
import com.motorsport_predictor.users_service.service.IGroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class GroupServiceImpl implements IGroupService {

    @Autowired
    private IGroupRepository groupRepository;

    // Listar todos los grupos
    @Override
    public List<GroupDTO> getAllGroups() {
        List<Group> groups = groupRepository.findAll();

        return groups.stream()
                .map(group -> GroupDTO.builder()
                        .name(group.getName())
                        .description(group.getDescription())
                        .isPublic(group.isPublic())
                        .createdAt(group.getCreatedAt())
                        .updatedAt(group.getUpdatedAt())
                        .creatorId(group.getCreatorId())
                        .isOfficial(group.isOfficial())
                        .discipline(group.getDiscipline())
                        .build())
                .collect(Collectors.toList());
    }

    // Obtener grupo por ID
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

    // Obtener grupo por nombre
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

    // Obtener grupo por disciplina
    @Override
    public List<GroupDTO> getGroupsByDiscipline(String discipline) {
        List<Group> groups = groupRepository.findByDiscipline(discipline);

        return groups.stream()
                .map(group -> GroupDTO.builder()
                        .name(group.getName())
                        .description(group.getDescription())
                        .isPublic(group.isPublic())
                        .createdAt(group.getCreatedAt())
                        .updatedAt(group.getUpdatedAt())
                        .creatorId(group.getCreatorId())
                        .isOfficial(group.isOfficial())
                        .discipline(group.getDiscipline())
                        .build())
                .collect(Collectors.toList());
    }

    // Obtener una lista de los grupos mas populares (teniendo en cuenta el numero de miembros)
    @Override
    public List<GroupDTO> getPopularGroups() {
        return null;
    }

    // Busca grupos por NOMBRE o DESCRIPTION
    @Override
    public List<GroupDTO> searchGroups(String searchTerm) {
        return null;
    }

    // Obtiene una lista de grupos de los cuales el usuario pertenece.
    @Override
    public List<GroupDTO> getGroupsByUserId(String userId) {
        return null;
    }

    // Crea un nuevo grupo
    @Override
    public GroupDTO createNewGroup(CreateGroupDTO createGroupDTO) {

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

        groupRepository.save(group);

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

    // Actualiza un grupo por ID
    @Override
    public void updateGroup(Long groupId, CreateGroupDTO createGroup) {

    }

    // Borra un grupo por ID
    @Override
    public void deleteGroupById(Long groupId) {
    }
}
