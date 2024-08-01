package com.motorsport_predictor.f1_service.repositories;

import com.motorsport_predictor.f1_service.models.Qualifying;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IQualifyingRepository extends JpaRepository<Qualifying, Long> {
}
