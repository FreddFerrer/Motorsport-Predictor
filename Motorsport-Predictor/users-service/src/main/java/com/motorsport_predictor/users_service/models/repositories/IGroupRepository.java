package com.motorsport_predictor.users_service.models.repositories;

import com.motorsport_predictor.users_service.models.entities.Group;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IGroupRepository extends JpaRepository<Group, Long> {
    Optional<Group> findById(Long id);
    Group findByName(String name);
    Group findByDiscipline(String discipline);
}
