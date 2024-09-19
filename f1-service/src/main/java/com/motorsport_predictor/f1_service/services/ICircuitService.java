package com.motorsport_predictor.f1_service.services;

import com.motorsport_predictor.f1_service.dto.CircuitDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


public interface ICircuitService {
    Page<CircuitDTO> getAllCircuit(Pageable pageable);
}
