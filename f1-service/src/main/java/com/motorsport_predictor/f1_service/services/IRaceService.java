package com.motorsport_predictor.f1_service.services;

import com.motorsport_predictor.f1_service.dto.RaceDTO;
import com.motorsport_predictor.f1_service.dto.request.RaceResultRequestDTO;

import java.util.List;

public interface IRaceService {
    List<RaceDTO> getAllRaces();
    RaceDTO getNextRace();
    boolean existById(Long raceId);
    RaceDTO getRaceById(Long raceId);
    void uploadRaceResults(Long raceId, RaceResultRequestDTO resultsRequest);
}