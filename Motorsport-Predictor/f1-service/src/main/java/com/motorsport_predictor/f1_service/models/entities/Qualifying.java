package com.motorsport_predictor.f1_service.models.entities;

import java.time.LocalDate;
import java.time.LocalTime;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "qualifying")
@Getter
@Setter
public class Qualifying {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "race_id")
    private Race race;

    private LocalDate date;
    private LocalTime time;
}
