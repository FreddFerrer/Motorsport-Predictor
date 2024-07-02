package com.fredd.motorsport_predictor.models.entities;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "invitations")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Invitation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private User user;

    @ManyToOne
    private PredictionGroup predictionGroup;

    private Boolean accept;

    private Boolean reject;
}
