package com.motorsport_predictor.f1_service.services.impl;

import com.motorsport_predictor.f1_service.dto.DriverDTO;
import com.motorsport_predictor.f1_service.dto.TeamDTO;
import com.motorsport_predictor.f1_service.models.entities.Driver;
import com.motorsport_predictor.f1_service.models.entities.Team;
import com.motorsport_predictor.f1_service.models.repositories.IDriverRepository;
import com.motorsport_predictor.f1_service.services.IDriverService;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DriverServiceImpl implements IDriverService {

    private final IDriverRepository driverRepository;

    @Override
    public List<DriverDTO> getAllDrivers() {
        List<Driver> drivers = driverRepository.findAll();

        return drivers.stream()
                .map(driver -> DriverDTO.builder()
                    .name(driver.getName())
                    .nationality(driver.getNationality())
                    .team(mapToTeamDTO(driver.getTeam()))
                    .build())
                .collect(Collectors.toList());
    }

    // Método para mapear Team a TeamDTO
    private TeamDTO mapToTeamDTO(Team team) {
        return TeamDTO.builder()
                .name(team.getName())
                .build();
    }
}
