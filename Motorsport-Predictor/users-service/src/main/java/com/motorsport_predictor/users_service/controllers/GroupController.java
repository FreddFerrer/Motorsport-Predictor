package com.motorsport_predictor.users_service.controllers;

import com.motorsport_predictor.users_service.dto.request.AddMemberByIdDTO;
import com.motorsport_predictor.users_service.dto.request.AddMemberByUsernameDTO;
import com.motorsport_predictor.users_service.dto.request.CreateGroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.service.IGroupMemberService;
import com.motorsport_predictor.users_service.service.IGroupService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
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

    @GetMapping("/")
    public ResponseEntity<?> getAllGroups(@PageableDefault(size = 10) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupService.getAllGroups(pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> getGroupById(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(groupService.getGroupById(id));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
    @GetMapping("/byName/{name}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupByName(@PathVariable String name) {
        try {
            return ResponseEntity.ok(groupService.getGroupByName(name));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    // return all the groups by User logged
    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
    @GetMapping("/byUser")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupByUser(Pageable pageable) {
        try {
            return ResponseEntity.ok(groupMemberService.getGroupsByUser(pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
    @GetMapping("/byDiscipline/{discipline}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupByDiscipline(@PathVariable String discipline, @PageableDefault(size = 10) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupService.getGroupsByDiscipline(discipline, pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/populars")
    public ResponseEntity<?> getPopularGroups() {
        try {
            return ResponseEntity.ok(groupService.getPopularGroups());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/search/{searchTerm}")
    public ResponseEntity<?> searchGroups(@PathVariable String searchTerm, @PageableDefault(size = 10) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupService.searchGroups(searchTerm, pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/{groupId}/members")
    public ResponseEntity<?> getMembersByGroup(@PathVariable Long groupId, @PageableDefault(size = 10) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupMemberService.getMembersByGroupId(groupId, pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
    @GetMapping("/byUserId/{userId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupsByUserId(@PathVariable String userId, @PageableDefault(size = 10) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupMemberService.getGroupsByUserId(userId, pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
    @GetMapping("/byUsername/{username}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupsByUsername(@PathVariable String username, @PageableDefault(size = 10) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupMemberService.getGroupsByUsername(username, pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    // Intern endpoint
    @GetMapping("/existUserInGroup/{groupId}/{userId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> existUserInGroup(@PathVariable Long groupId, @PathVariable String userId) {
        try {
            return ResponseEntity.ok(groupMemberService.isUserInGroup(groupId, userId));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
    @PostMapping("/create")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> createGroup(@RequestBody @Valid CreateGroupDTO createGroupDTO) {
        try {
            GroupDTO group = groupService.createNewGroup(createGroupDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(group);
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
    @PostMapping("/{groupId}/newMemberId")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> addMemberById(@PathVariable Long groupId, @RequestBody @Valid AddMemberByIdDTO newMemberToGroupDTO) {
        try {
            groupMemberService.addMemberToGroupById(groupId, newMemberToGroupDTO.getUserId());
            return ResponseEntity.status(HttpStatus.CREATED).body("successfully");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
    @PostMapping("/{groupId}/newMemberUsername")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> addMemberByUsername(@PathVariable Long groupId, @RequestBody AddMemberByUsernameDTO newMemberByUsernameDTO) {
        try {
            groupMemberService.addMemberToGroupByUsername(groupId, newMemberByUsernameDTO.getUsername());
            return ResponseEntity.status(HttpStatus.CREATED).body("successfully");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> deleteGroupById(@PathVariable Long id) {
        try {
            groupService.deleteGroupById(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(summary = "Endpoint protegido", security = @SecurityRequirement(name = "Bearer Authentication"))
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
}