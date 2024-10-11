package com.motorsport_predictor.predictions_service.models.repositories;

import com.motorsport_predictor.predictions_service.models.entities.F1Prediction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IF1PredictionRepository extends JpaRepository<F1Prediction, Long> {
    int countByGroupMemberIdAndRaceId(Long memberGroupId, Long raceId);
    List<F1Prediction> findByRaceId(Long raceId);
}