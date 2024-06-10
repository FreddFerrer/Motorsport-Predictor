package com.fredd.motorsport_predictor.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PredictionGroupRequestDto {
    private Long id;

    private String groupName;

    private String groupType;
}
