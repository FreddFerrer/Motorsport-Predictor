package com.motorsport_predictor.f1_service.models.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Table(name = "circuit")
@Getter
@Setter
public class Circuit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "circuit_short_name")
    private String circuitShortName;
    @Column(name = "circuit_name")
    private String circuitName;
    @Column(name = "lat")
    private BigDecimal lat;
    @Column(name = "lon")
    private BigDecimal lon;
    @Column(name = "locality")
    private String locality;
    @Column(name = "country")
    private String country;
}
