package com.motorsport_predictor.users_service.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

@Getter
@Setter
public class CreateGroupDTO {
    @NotEmpty(message = "Required field")
    @NotNull
    @Length(min = 5, max = 32, message = "must have between 6 and 32 characters")
    private String name;

    private String description;

    @NotEmpty(message = "Required field")
    @NotNull
    private String discipline;

    @NotEmpty(message = "Required field")
    @NotNull
    private boolean isPublic;
}
