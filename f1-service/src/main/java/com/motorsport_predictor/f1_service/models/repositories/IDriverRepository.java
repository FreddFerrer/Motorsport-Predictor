package com.motorsport_predictor.f1_service.models.repositories;

import com.motorsport_predictor.f1_service.models.entities.Driver;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IDriverRepository  extends JpaRepository<Driver, Long> {
    // Método personalizado para contar cuántos IDs existen en la lista dada
    long countByIdIn(List<Long> driverIds);
    Optional<Driver> findByShortcode(String shortcode);
}
