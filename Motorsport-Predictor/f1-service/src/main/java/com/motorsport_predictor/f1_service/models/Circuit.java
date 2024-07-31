package com.motorsport_predictor.f1_service.models;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "Circuit")
@Getter
@Setter
public class Circuit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "circuitShortName")
    private String circuitShortName;

    @Column(name = "circuitName")
    private String circuitName;

    @Column(precision = 10, scale = 7)
    private Double lat;

    @Column(precision = 10, scale = 7)
    private Double lon;

    @Column(name = "locality")
    private String locality;

    @Column(name = "country")
    private String country;
}
