package com.motorsport_predictor.f1_service.models.repositories;

import com.motorsport_predictor.f1_service.models.entities.Circuit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ICircuitRepository extends JpaRepository<Circuit, Long>{
}
