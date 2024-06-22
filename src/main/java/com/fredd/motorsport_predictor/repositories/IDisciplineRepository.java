package com.fredd.motorsport_predictor.repositories;

import com.fredd.motorsport_predictor.enums.DisciplineEnum;
import com.fredd.motorsport_predictor.models.entities.Discipline;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IDisciplineRepository extends JpaRepository<Discipline, Integer> {
    Optional<Discipline> findByDisciplineName(DisciplineEnum disciplineName);
}