package com.motorsport_predictor.f1_service.services;

import com.motorsport_predictor.f1_service.dto.DriverDTO;

import java.util.List;

public interface IDriverService {
    List<DriverDTO> getAllDrivers();
    boolean existById(Long driverId);
}
