package com.fredd.motorsport_predictor.models.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "prediction_groups")
@Getter
@Setter
public class PredictionGroup {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "group_name", nullable = false, length = 100)
    private String groupName;

    @Column(name = "is_oficial", nullable = false)
    private boolean isOficial;

    @ManyToOne
    @JoinColumn(name = "creator_id")
    private User creator;

    @ManyToOne
    @JoinColumn(name = "discipline_id", nullable = false)
    private Discipline discipline;

}
