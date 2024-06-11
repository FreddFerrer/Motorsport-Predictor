package com.fredd.motorsport_predictor.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class PredictionGroupDto {

    private int id;

    private String groupName;

    private String groupType;

    private UserDto creator;
}
