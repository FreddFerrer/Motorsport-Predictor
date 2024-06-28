package com.fredd.motorsport_predictor.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Set;

@Getter
@Setter
public class UserDto {
    private Long id;
    private String username;
    private String firstName;
    private String secondName;
    private String userNationality;
    private String userEmail;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String token;
    private LocalDateTime dateOfRegistration;
}
