package com.fredd.motorsport_predictor.repositories;

import com.fredd.motorsport_predictor.models.entities.PredictionGroup;
import com.fredd.motorsport_predictor.models.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface IPredictionGroupRepository extends JpaRepository<PredictionGroup, Long> {

    Optional<PredictionGroup> findByCreator(User creator);
}
