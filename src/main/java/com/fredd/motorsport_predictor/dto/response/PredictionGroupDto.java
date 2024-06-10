package com.fredd.motorsport_predictor.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PredictionGroupDto {

    private int id;

    private String groupName;

    private String groupType;

    private UserDto creator;
}
