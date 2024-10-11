package com.motorsport_predictor.f1_service.services;

import com.motorsport_predictor.f1_service.dto.DriverDTO;
import com.motorsport_predictor.f1_service.models.entities.Driver;

import java.util.List;
import java.util.Optional;

public interface IDriverService {
    List<DriverDTO> getAllDrivers();
    List<Long> getDriverIdsByShortname(List<String> shortname);
    Optional<Driver> getDriverIdByShortname(String shortname);
}