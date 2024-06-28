package com.fredd.motorsport_predictor.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PredictionGroupDto {
    private Long id;
    private String groupName;
    private UserDto creator;
}
