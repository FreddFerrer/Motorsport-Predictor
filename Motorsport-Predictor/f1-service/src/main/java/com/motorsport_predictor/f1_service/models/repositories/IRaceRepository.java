package com.motorsport_predictor.f1_service.models.repositories;

import com.motorsport_predictor.f1_service.models.entities.Race;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IRaceRepository extends JpaRepository<Race, Long> {
    @Query("SELECT r FROM Race r WHERE r.date > CURRENT_DATE ORDER BY r.date ASC LIMIT 1")
    Optional<Race> findNextRace();
}
