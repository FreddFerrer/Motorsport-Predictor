package com.motorsport_predictor.users_service.models.repositories;

import com.motorsport_predictor.users_service.models.entities.Group;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IGroupRepository extends JpaRepository<Group, Long> {
    Optional<Group> findByName(String name);
    Page<Group> findByDiscipline(String discipline, Pageable pageable);
    @Query("SELECT g FROM Group g WHERE g.name LIKE %:searchTerm% OR g.description LIKE %:searchTerm%")
    Page<Group> searchGroups(@Param("searchTerm") String searchTerm, Pageable pageable);
    List<Group> findTop10ByOrderByMemberCountDesc();

    Page<Group> findByIdIn(List<Long> groupIds, Pageable pageable);

}
