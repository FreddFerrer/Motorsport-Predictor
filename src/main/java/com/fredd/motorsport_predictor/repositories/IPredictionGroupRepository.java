package com.fredd.motorsport_predictor.repositories;

import com.fredd.motorsport_predictor.models.entities.PredictionGroup;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IPredictionGroupRepository extends JpaRepository<PredictionGroup, Long> {
}
