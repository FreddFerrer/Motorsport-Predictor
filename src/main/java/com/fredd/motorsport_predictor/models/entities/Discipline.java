package com.fredd.motorsport_predictor.models.entities;

import com.fredd.motorsport_predictor.enums.DisciplineEnum;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "discipline")
@Getter
@Setter
public class Discipline {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "discipline_name", nullable = false, length = 100)
    @Enumerated(EnumType.STRING)
    private DisciplineEnum disciplineName;
}
