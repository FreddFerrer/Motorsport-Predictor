package com.motorsport_predictor.users_service.service.impl;

import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupMemberDTO;
import com.motorsport_predictor.users_service.exceptions.ResourceNotFoundException;
import com.motorsport_predictor.users_service.models.entities.Group;
import com.motorsport_predictor.users_service.models.entities.GroupMember;
import com.motorsport_predictor.users_service.models.repositories.IGroupMemberRepository;
import com.motorsport_predictor.users_service.models.repositories.IGroupRepository;
import com.motorsport_predictor.users_service.service.IGroupMemberService;
import com.motorsport_predictor.users_service.util.KeycloakProvider;
import org.keycloak.admin.client.resource.UserResource;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.security.Timestamp;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class GroupMemberServiceImpl implements IGroupMemberService {

    @Autowired
    private IGroupMemberRepository groupMemberRepository;
    @Autowired
    private IGroupRepository groupRepository;

    @Override
    public void addMemberToGroupById(Long groupId, String userId) {
        Group group;
        UserResource user;

        //Busca el usuario por el ID
        try {
            user = KeycloakProvider.getUserResource()
                    .get(userId);
        } catch (Exception e) {
            throw new ResourceNotFoundException("userId " + userId);
        }

        // Busca y comprueba que el Id del grupo exista
        if (!groupRepository.existsById(groupId)) {
            throw new ResourceNotFoundException("groupId" + groupId);
        } else {
            group = groupRepository.getReferenceById(groupId);
        }

        GroupMember groupMember = new GroupMember();
        groupMember.setGroup(group);
        groupMember.setUserId(user.toRepresentation().getId());
        groupMember.setJoinedAt(LocalDateTime.now());

        try {
            groupMemberRepository.save(groupMember);
        } catch (DataIntegrityViolationException e) {
            // Manejar error de restricción de unicidad
            throw new DataIntegrityViolationException("Error saving group");
        }
    }

    @Override
    public void addMemberToGroupByUsername(Long groupId, String username) {
        Group group;

        List<UserRepresentation> users = KeycloakProvider.getUserResource().search(username);

        // Verifica si el usuario existe
        if (users == null || users.isEmpty()) {
            throw new ResourceNotFoundException("username: " + username);
        }

        // Se asume que el username es único y se toma el primer resultado
        UserRepresentation user = users.get(0);

        if (!groupRepository.existsById(groupId)) {
            throw new ResourceNotFoundException("groupId" + groupId);
        } else {
            group = groupRepository.getReferenceById(groupId);
        }

        GroupMember groupMember = new GroupMember();
        groupMember.setGroup(group);
        groupMember.setUserId(user.getId());
        groupMember.setJoinedAt(LocalDateTime.now());

        try {
            groupMemberRepository.save(groupMember);
        } catch (DataIntegrityViolationException e) {
            // Manejar error de restricción de unicidad
            throw new DataIntegrityViolationException("Error saving group");
        }
    }

    @Override
    public void removeMemberFromGroupById(Long groupId, String userId) {
        Group group;
        UserResource user;

        //Busca el usuario por el ID
        try {
            user = KeycloakProvider.getUserResource()
                    .get(userId);
        } catch (Exception e) {
            throw new ResourceNotFoundException("userId " + userId);
        }

        // Busca y comprueba que el Id del grupo exista
        if (!groupRepository.existsById(groupId)) {
            throw new ResourceNotFoundException("groupId " + groupId);
        } else {
            group = groupRepository.getReferenceById(groupId);
        }

        // Guardo los id correctos
        Long groupIdObtained = group.getId();
        String userIdObtained = user.toRepresentation().getId();

        // Verifico si el usuario es miembro del grupo
        GroupMember groupMember = groupMemberRepository.findByGroupIdAndUserId(groupIdObtained, user.toRepresentation().getId())
                .orElseThrow(() -> new ResourceNotFoundException("User " + userId + " is not a member of group " + groupId));

        // Elimino el miembro del grupo
        groupMemberRepository.delete(groupMember);
    }

    @Override
    public List<GroupMemberDTO> getMembersByGroupId(Long groupId) {
        // Verificar si el grupo existe
        Group group = groupRepository.findById(groupId)
                .orElseThrow(() -> new ResourceNotFoundException("Group with ID " + groupId + " not found"));

        // Obtener los id de los miembros y sus fechas de ingreso
        List<Object[]> members = groupMemberRepository.findUserIdAndJoinedAtByGroupId(groupId);

        // Separar los ids de los usuarios
        List<String> memberIds = members.stream()
                .map(member -> (String) member[0])
                .collect(Collectors.toList());

        // Obtener de keycloak la lista de usuarios que corresponden a ese id
        List<UserRepresentation> keycloakUsers = KeycloakProvider.getUsersByIds(memberIds);

        // Crear un mapa de id de usuario a UserRepresentation para acceso rápido
        Map<String, UserRepresentation> userMap = keycloakUsers.stream()
                .collect(Collectors.toMap(UserRepresentation::getId, Function.identity()));

        // Mapear los datos a GroupMemberDTOs
        return members.stream()
                .map(member -> {
                    String userId = (String) member[0];
                    LocalDateTime joinedAt = (LocalDateTime) member[1];
                    UserRepresentation user = userMap.get(userId);


                    GroupMemberDTO dto = new GroupMemberDTO();
                    dto.setUserId(userId);
                    dto.setUsername(user.getUsername());
                    dto.setJoinedAt(joinedAt);
                    return dto;
                })
                .collect(Collectors.toList());
    }

    @Override
    public List<GroupDTO> getGroupsByUserId(String userId) {
        // Obtener el id del usuario y comprobar si existe.
        UserRepresentation user = KeycloakProvider.getUserById(userId);

        // Obtener todos los Id de los grupos a los que esta relacionado ese usuario (un usuario puede estar en varios grupos distintos, nunca puede estar 2 veces en un mismo grupo)
        List<Long> groupIds = groupMemberRepository.findGroupIdsByUserId(userId);
        if (groupIds.isEmpty()) {
            return Collections.emptyList(); // Retornar lista vacía si no pertenece a ningún grupo
        }

        // Consultar datos de los grupos teniendo en cuenta los id obtenidos anteriormente.
        List<Group> groups = groupRepository.findAllById(groupIds);

        // Mapear los grupos a DTOs
        return groups.stream()
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

    @Override
    public List<GroupDTO> getGroupsByUsername(String username) {
        return null;
    }

}
