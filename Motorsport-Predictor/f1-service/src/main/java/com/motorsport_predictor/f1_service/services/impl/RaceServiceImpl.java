package com.motorsport_predictor.f1_service.services.impl;

import com.motorsport_predictor.f1_service.dto.CircuitDTO;
import com.motorsport_predictor.f1_service.dto.RaceDTO;
import com.motorsport_predictor.f1_service.exceptions.ResourceNotFoundException;
import com.motorsport_predictor.f1_service.models.entities.Circuit;
import com.motorsport_predictor.f1_service.models.entities.Race;
import com.motorsport_predictor.f1_service.models.repositories.IRaceRepository;
import com.motorsport_predictor.f1_service.services.IRaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RaceServiceImpl implements IRaceService {
    private final IRaceRepository raceRepository;

    @Override
    public List<RaceDTO> getAllRaces() {
        List<Race> races = raceRepository.findAll();
        return races.stream()
                .map(r -> RaceDTO.builder()
                        .raceName(r.getRaceName())
                        .round(r.getRound())
                        .season(r.getSeason())
                        .circuit(mapToCircuitDto(r.getCircuit()))
                        .date(r.getDate())
                        .time(r.getTime())
                        .build())
                .collect(Collectors.toList());
    }

    private CircuitDTO mapToCircuitDto(Circuit circuit) {
        return CircuitDTO.builder()
                .circuitName(circuit.getCircuitName())
                .locality(circuit.getLocality())
                .country(circuit.getCountry())
                .build();
    }

    @Override
    public RaceDTO getNextRace() {
        Race nextRace = raceRepository.findNextRace().orElseThrow(() -> new ResourceNotFoundException("Race not found"));

        return RaceDTO.builder()
                .season(nextRace.getSeason())
                .round(nextRace.getRound())
                .raceName(nextRace.getRaceName())
                .circuit(mapToCircuitDto(nextRace.getCircuit()))
                .date(nextRace.getDate())
                .time(nextRace.getTime())
                .build();
    }

    @Override
    public boolean existById(Long raceId) {
        boolean race = raceRepository.existsById(raceId);

        if (!race) {
            throw new ResourceNotFoundException("raceId" + raceId);
        } else {
            return true;
        }
    }

    @Override
    public RaceDTO getRaceById(Long raceId) {
        Race race = raceRepository.findById(raceId).orElseThrow(() -> new ResourceNotFoundException("Race does not exist"));
        return RaceDTO.builder()
                .season(race.getSeason())
                .round(race.getRound())
                .raceName(race.getRaceName())
                .circuit(mapToCircuitDto(race.getCircuit()))
                .date(race.getDate())
                .time(race.getTime())
                .build();
    }
}
