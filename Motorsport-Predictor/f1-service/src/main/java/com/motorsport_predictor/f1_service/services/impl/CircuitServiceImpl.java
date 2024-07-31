package com.motorsport_predictor.f1_service.services.impl;

import com.motorsport_predictor.f1_service.models.Circuit;
import com.motorsport_predictor.f1_service.repositories.ICircuitRepository;
import com.motorsport_predictor.f1_service.services.ICircuitService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CircuitServiceImpl implements ICircuitService {

    @Autowired
    private ICircuitRepository circuitRepository;

    @Override
    public List<Circuit> findAllCircuit() {
        return circuitRepository.findAll();
    }
}
