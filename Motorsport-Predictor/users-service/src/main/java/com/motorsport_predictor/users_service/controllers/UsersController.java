package com.motorsport_predictor.users_service.controllers;

import com.motorsport_predictor.users_service.dto.request.CreateUserDTO;
import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.service.IUserService;
import org.keycloak.representations.idm.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@CrossOrigin
public class UsersController {

    @Autowired
    private IUserService userService;

    @GetMapping()
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> findAllUsers(){
        try {
            return ResponseEntity.ok(userService.findAllUsers());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/search/{username}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> searchUserByUsername(@PathVariable String username){
        try {
            return ResponseEntity.ok(userService.searchUserByUsername(username));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @GetMapping("/getLoggedUser")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getUserLoggedId(){
        try {
            return ResponseEntity.ok(userService.getLoggedInUserId());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @PostMapping("/create")
    public ResponseEntity<?> createUser(@RequestBody CreateUserDTO userDTO) {
        try {
            UserRepresentation response = userService.createUser(userDTO);
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(response);
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }


    @PutMapping("/update/{userId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> updateUser(@PathVariable String userId, @RequestBody CreateUserDTO userDTO){
        try {
            userService.updateUser(userId, userDTO);
            return ResponseEntity.ok("User updated successfully");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }


    @DeleteMapping("/delete/{userId}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> deleteUser(@PathVariable String userId){
        userService.deleteUser(userId);
        return ResponseEntity.noContent().build();
    }
}
