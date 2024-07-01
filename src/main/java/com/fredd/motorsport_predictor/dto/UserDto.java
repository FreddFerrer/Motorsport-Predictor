package com.fredd.motorsport_predictor.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Set;

@Getter
@Setter
public class UserDto {
    private int id;
    private String username;
    private String firstName;
    private String secondName;
    private String userNationality;
    private String userEmail;
    private LocalDateTime dateOfRegistration;
    private Set<PredictionGroupDto> predictionGroups;
}
