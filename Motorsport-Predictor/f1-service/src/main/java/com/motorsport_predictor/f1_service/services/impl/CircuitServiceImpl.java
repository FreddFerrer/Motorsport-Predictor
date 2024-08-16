package com.motorsport_predictor.f1_service.services.impl;

import com.motorsport_predictor.f1_service.dto.CircuitDTO;
import com.motorsport_predictor.f1_service.models.entities.Circuit;
import com.motorsport_predictor.f1_service.models.repositories.ICircuitRepository;
import com.motorsport_predictor.f1_service.services.ICircuitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CircuitServiceImpl implements ICircuitService {

    @Autowired
    private ICircuitRepository circuitRepository;

    @Override
    public List<CircuitDTO> getAllCircuit() {
        List<Circuit> circuits = circuitRepository.findAll();
        return circuits.stream()
                .map(circuit -> CircuitDTO.builder()
                        .circuitName(circuit.getCircuitName())
                        .locality(circuit.getLocality())
                        .country(circuit.getCountry())
                        .build())
                .collect(Collectors.toList());
    }
}
