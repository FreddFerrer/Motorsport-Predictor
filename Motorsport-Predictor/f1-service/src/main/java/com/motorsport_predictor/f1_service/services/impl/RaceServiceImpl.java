package com.motorsport_predictor.f1_service.services.impl;

import com.motorsport_predictor.f1_service.dto.CircuitDTO;
import com.motorsport_predictor.f1_service.dto.RaceDTO;
import com.motorsport_predictor.f1_service.dto.request.RaceResultRequestDTO;
import com.motorsport_predictor.f1_service.exceptions.ResourceNotFoundException;
import com.motorsport_predictor.f1_service.feign.IPredictionsClient;
import com.motorsport_predictor.f1_service.models.entities.Circuit;
import com.motorsport_predictor.f1_service.models.entities.Race;
import com.motorsport_predictor.f1_service.models.repositories.IDriverRepository;
import com.motorsport_predictor.f1_service.models.repositories.IRaceRepository;
import com.motorsport_predictor.f1_service.services.IRaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RaceServiceImpl implements IRaceService {
    private final IRaceRepository raceRepository;
    private final IPredictionsClient predictionsClient;
    private final IDriverRepository driverRepository;

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
            return false;
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

    @Override
    public void uploadRaceResults(Long raceId, RaceResultRequestDTO results) {


        // Verificar si existe el piloto y que no se repitan los driverId
        Set<Long> driverIds = new HashSet<>();
        results.getRaceResult().forEach(result -> {
            boolean driverExists = driverRepository.existsById(result.getDriverId());
            if (!driverExists) {
                throw new IllegalArgumentException("El piloto con ID " + result.getDriverId() + " no existe.");
            }
            if (!driverIds.add(result.getDriverId())) {
                throw new IllegalArgumentException("El piloto con ID " + result.getDriverId() + " ya ha sido asignado a una posición.");
            }
        });

        // Verificar que las posiciones no se repitan
        Set<Integer> positions = new HashSet<>();
        results.getRaceResult().forEach(result -> {
            int position = result.getPosition();
            if (position < 1 || position > 10) {
                throw new IllegalArgumentException("La posición " + position + " es inválida. Debe estar entre 1 y 10.");
            }
            if (!positions.add(position)) {
                throw new IllegalArgumentException("La posición " + position + " ya ha sido asignada a otro piloto.");
            }
        });

        predictionsClient.sendRaceResults(raceId, results);
    }
}
