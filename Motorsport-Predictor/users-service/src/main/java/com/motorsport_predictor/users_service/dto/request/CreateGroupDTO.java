package com.motorsport_predictor.users_service.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.Length;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CreateGroupDTO {
    @NotEmpty(message = "Required field")
    @NotNull
    @Length(min = 5, max = 32, message = "must have between 6 and 32 characters")
    private String name;
    private String description;
    @NotEmpty(message = "Required field")
    @NotNull
    private String discipline;
    @NotNull(message = "Required field")
    @JsonProperty("isPublic")
    private boolean isPublic;
}