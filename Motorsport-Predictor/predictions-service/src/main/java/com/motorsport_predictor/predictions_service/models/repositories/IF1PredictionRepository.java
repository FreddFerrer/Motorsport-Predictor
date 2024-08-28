package com.motorsport_predictor.predictions_service.models.repositories;

import com.motorsport_predictor.predictions_service.models.entities.F1Prediction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface IF1PredictionRepository extends JpaRepository<F1Prediction, Long> {

    int countByGroupMemberIdAndRaceId(Long memberGroupId, Long raceId);
    @Modifying
    @Query("UPDATE F1Prediction p SET p.actualPosition = :position WHERE p.raceId = :raceId AND p.driverId = :driverId")
    void updateActualPosition(@Param("position") int position, @Param("raceId") Long raceId, @Param("driverId") Long driverId);
}