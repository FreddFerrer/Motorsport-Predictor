package com.fredd.motorsport_predictor.repositories;

import com.fredd.motorsport_predictor.models.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IUserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    Optional<User> findByUserEmail(String email);
    boolean existsByUsername(String username);
    boolean existsByUserEmail(String email);
}
