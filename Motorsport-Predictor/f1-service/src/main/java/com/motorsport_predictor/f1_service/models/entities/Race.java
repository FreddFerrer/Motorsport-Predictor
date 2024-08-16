package com.motorsport_predictor.f1_service.models.entities;

import java.time.LocalDate;
import java.time.LocalTime;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "race")
@Getter
@Setter
public class Race {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String season;
    private Integer round;
    @JoinColumn(name = "race_name")
    private String raceName;
    @ManyToOne
    @JoinColumn(name = "circuit_id")
    private Circuit circuit;
    private LocalDate date;
    private LocalTime time;

}
