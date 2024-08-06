package com.motorsport_predictor.f1_service.models.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "practice_session")
@Getter
@Setter
public class PracticeSession {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "race_id")
    private Race race;

    @Column(name = "session_name")
    private String sessionName;

    private LocalDate date;
    private LocalTime time;

}
