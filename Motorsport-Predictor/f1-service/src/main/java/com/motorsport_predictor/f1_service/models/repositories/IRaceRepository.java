package com.motorsport_predictor.f1_service.models.repositories;

import com.motorsport_predictor.f1_service.models.entities.Race;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IRaceRepository extends JpaRepository<Race, Long> {
}
