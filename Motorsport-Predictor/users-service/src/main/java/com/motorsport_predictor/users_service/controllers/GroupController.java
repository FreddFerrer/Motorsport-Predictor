package com.motorsport_predictor.users_service.controllers;

import com.motorsport_predictor.users_service.dto.CreateGroupDTO;
import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.models.entities.Group;
import com.motorsport_predictor.users_service.service.IGroupService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/groups")
@CrossOrigin
public class GroupController {

    @Autowired
    private IGroupService groupService;

    @GetMapping("/list")
    public ResponseEntity<?> getAllGroups() {
        try {
            return ResponseEntity.ok(groupService.getAllGroups());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> getGroupById(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(groupService.getGroupById(id));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/byName/{name}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupByName(@PathVariable String name) {
        try {
            return ResponseEntity.ok(groupService.getGroupByName(name));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/byDiscipline/{discipline}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupByDiscipline(@PathVariable String discipline) {
        try {
            return ResponseEntity.ok(groupService.getGroupByDiscipline(discipline));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @PostMapping("/create")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> createGroup(@RequestBody @Valid CreateGroupDTO createGroupDTO) {
        try {
            Group group = groupService.createNewGroup(createGroupDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(group);
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> deleteGroupById(@PathVariable Long id) {
        try {
            groupService.deleteGroupById(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }
}
