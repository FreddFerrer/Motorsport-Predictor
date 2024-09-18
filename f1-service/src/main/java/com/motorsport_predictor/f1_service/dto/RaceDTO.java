package com.motorsport_predictor.f1_service.dto;

import lombok.Builder;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalTime;

@Data
@Builder
public class RaceDTO {
    private String season;
    private Integer round;
    private String raceName;
    private CircuitDTO circuit;
    private LocalDate date;
    private LocalTime time;
}
