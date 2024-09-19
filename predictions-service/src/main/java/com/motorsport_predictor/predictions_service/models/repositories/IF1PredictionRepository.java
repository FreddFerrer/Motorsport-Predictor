package com.motorsport_predictor.predictions_service.models.repositories;

import com.motorsport_predictor.predictions_service.models.entities.F1Prediction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IF1PredictionRepository extends JpaRepository<F1Prediction, Long> {
    int countByGroupMemberIdAndRaceId(Long memberGroupId, Long raceId);
}