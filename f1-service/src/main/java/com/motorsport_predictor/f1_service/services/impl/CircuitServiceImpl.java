package com.motorsport_predictor.f1_service.services.impl;

import com.motorsport_predictor.f1_service.dto.CircuitDTO;
import com.motorsport_predictor.f1_service.models.entities.Circuit;
import com.motorsport_predictor.f1_service.models.repositories.ICircuitRepository;
import com.motorsport_predictor.f1_service.services.ICircuitService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CircuitServiceImpl implements ICircuitService {
    private final ICircuitRepository circuitRepository;

    @Override
    public Page<CircuitDTO> getAllCircuit(Pageable pageable) {
        Page<Circuit> circuits = circuitRepository.findAll(pageable);

        return circuits.map(circuit -> CircuitDTO.builder()
                .circuitName(circuit.getCircuitName())
                .locality(circuit.getLocality())
                .country(circuit.getCountry())
                .build());
    }
}
