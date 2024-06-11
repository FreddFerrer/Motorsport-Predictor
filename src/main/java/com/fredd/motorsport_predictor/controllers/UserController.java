package com.fredd.motorsport_predictor.controllers;

import com.fredd.motorsport_predictor.dto.response.UserDto;
import com.fredd.motorsport_predictor.service.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1/")
@RequiredArgsConstructor
public class UserController {

    private final IUserService iUserService;

    // Nuevo método para obtener todos los usuarios
    @GetMapping("/users")
    public ResponseEntity<?> getAllUsers() {
        List<UserDto> users = iUserService.getAllUsers();
        return ResponseEntity.ok(users);
    }

    // Nuevo método para obtener un usuario por ID
    @GetMapping("/users/{id}")
    public ResponseEntity<?> getUserById(@PathVariable Long id) {
        Optional<UserDto> user = iUserService.getUserById(id);
        return user.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

}
