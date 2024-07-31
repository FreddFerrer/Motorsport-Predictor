package com.motorsport_predictor.f1_service.models;

import java.time.LocalDate;
import java.time.LocalTime;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "Race")
@Getter
@Setter
public class Race {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;


    private String season;
    private Integer round;
    private String raceName;

    @ManyToOne
    @JoinColumn(name = "circuit_id")
    private Circuit circuit;

    private LocalDate date;
    private LocalTime time;

}
