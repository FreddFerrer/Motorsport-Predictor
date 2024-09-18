package com.motorsport_predictor.notification_service.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RaceDTO {
    private String season;
    private Integer round;
    private String raceName;
    private CircuitDTO circuit;
    private LocalDate date;
    private LocalTime time;
    private String email;
}