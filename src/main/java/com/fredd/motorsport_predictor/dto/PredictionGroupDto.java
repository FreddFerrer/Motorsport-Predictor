package com.fredd.motorsport_predictor.dto;

import com.fredd.motorsport_predictor.models.entities.User;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PredictionGroupDto {

    private int id;

    private String groupName;

    private String groupType;

    private User creator;
}
