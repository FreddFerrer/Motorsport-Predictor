package com.fredd.motorsport_predictor.repositories;

import com.fredd.motorsport_predictor.models.entities.PredictionGroup;
import com.fredd.motorsport_predictor.models.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface IPredictionGroupRepository extends JpaRepository<PredictionGroup, Long> {

    Optional<PredictionGroup> findByCreator(String creator);
}
