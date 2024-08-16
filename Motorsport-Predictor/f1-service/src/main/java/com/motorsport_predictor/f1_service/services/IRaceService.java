package com.motorsport_predictor.f1_service.services;

import com.motorsport_predictor.f1_service.dto.RaceDTO;

import java.util.List;

public interface IRaceService {
    List<RaceDTO> getAllRaces();
    RaceDTO getNextRace();
}
