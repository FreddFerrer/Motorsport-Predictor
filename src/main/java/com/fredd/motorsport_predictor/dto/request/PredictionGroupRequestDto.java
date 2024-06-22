package com.fredd.motorsport_predictor.dto.request;

import com.fredd.motorsport_predictor.enums.DisciplineEnum;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PredictionGroupRequestDto {
    @NotEmpty(message = "Required field")
    @NotNull
    private String groupName;

    @NotEmpty(message = "Required field")
    @NotNull
    private DisciplineEnum discipline;
}
