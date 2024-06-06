package com.fredd.motorsport_predictor.exceptions;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

import java.util.Map;

@Getter
@Setter
public class CustomErrorResponse {
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String message;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Map<String, String> errors;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String path;

    public CustomErrorResponse(String message, String path) {
        this.message = message;
        this.path = path;
    }

    public CustomErrorResponse(String message, Map<String, String> errors) {
        this.message = message;
        this.errors = errors;
    }

}
