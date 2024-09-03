package com.motorsport_predictor.users_service.dto.request;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AddMemberByIdDTO {

    @NotEmpty(message = "Required field")
    @NotNull
    private String userId;
}
