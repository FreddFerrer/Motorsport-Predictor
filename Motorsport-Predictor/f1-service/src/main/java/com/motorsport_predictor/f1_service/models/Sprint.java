package com.motorsport_predictor.f1_service.models;

import java.time.LocalDate;
import java.time.LocalTime;
import jakarta.persistence.*;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "Sprint")
@Getter
@Setter
public class Sprint {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "race_id")
    private Race race;

    private LocalDate date;
    private LocalTime time;




}
