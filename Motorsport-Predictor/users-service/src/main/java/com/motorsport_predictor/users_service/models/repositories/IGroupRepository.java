package com.motorsport_predictor.users_service.models.repositories;

import com.motorsport_predictor.users_service.models.entities.Group;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IGroupRepository extends JpaRepository<Group, Long> {
    Optional<Group> findByName(String name);
    List<Group> findByDiscipline(String discipline);
    @Query("SELECT g FROM Group g WHERE g.name LIKE %:searchTerm% OR g.description LIKE %:searchTerm%")
    List<Group> searchGroups(@Param("searchTerm") String searchTerm);
    List<Group> findTop10ByOrderByMemberCountDesc();
}
