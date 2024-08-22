package com.motorsport_predictor.predictions_service.models.entities;

import jakarta.persistence.*;
import lombok.*;

import java.security.Timestamp;
import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "f1_predictions")
public class F1Prediction {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "driver_id")
    private Long driver;

    @Column(name = "race_id", nullable = false)
    private Long raceId;

    @Column(name = "group_member_id", nullable = false)
    private Long groupMemberId;

    @Column(name = "predicted_position", nullable = false)
    private Integer predictedPosition;

    @Column(name = "actual_position")
    private Integer actualPosition;

    @Column(name = "points")
    private Integer points;

    @Column(name = "created_at")
    private LocalDateTime createdAt;
}