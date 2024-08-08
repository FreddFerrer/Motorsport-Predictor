package com.motorsport_predictor.users_service.controllers;

import com.motorsport_predictor.users_service.dto.request.AddMemberByIdDTO;
import com.motorsport_predictor.users_service.dto.request.AddMemberByUsernameDTO;
import com.motorsport_predictor.users_service.dto.request.CreateGroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.service.IGroupMemberService;
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
    @Autowired
    private IGroupMemberService groupMemberService;

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
            return ResponseEntity.ok(groupService.getGroupsByDiscipline(discipline));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @PostMapping("/create")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> createGroup(@RequestBody @Valid CreateGroupDTO createGroupDTO) {
        try {
            GroupDTO group = groupService.createNewGroup(createGroupDTO);
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

    @PostMapping("/{groupId}/addMemberById")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> addMemberById(@PathVariable Long groupId, @RequestBody @Valid AddMemberByIdDTO newMemberToGroupDTO) {
        try {
            groupMemberService.addMemberToGroupById(groupId, newMemberToGroupDTO.getUserId());
            return ResponseEntity.status(HttpStatus.CREATED).body("en teoria se agrego rey");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @PostMapping("/{groupId}/addMemberByUsername")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> addMemberByUsername(@PathVariable Long groupId, @RequestBody AddMemberByUsernameDTO newMemberByUsernameDTO) {
        System.out.println("Y ACA?????");
        try {
            System.out.println(("??????Request body: {}" + newMemberByUsernameDTO));
            groupMemberService.addMemberToGroupByUsername(groupId, newMemberByUsernameDTO.getUsername());

            return ResponseEntity.status(HttpStatus.CREATED).body("en teoria se agrego rey");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @DeleteMapping("/{groupId}/deleteMember/{userId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> deleteMemberFromGroupById(@PathVariable Long groupId, @PathVariable String userId) {
        try {
            groupMemberService.removeMemberFromGroupById(groupId, userId);

            return ResponseEntity.status(HttpStatus.NO_CONTENT).body("User removed from group");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/{groupId}/getMembers")
    //@PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getMembersByGroup(@PathVariable Long groupId) {
        try {
            return ResponseEntity.ok(groupMemberService.getMembersByGroupId(groupId));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }
}
