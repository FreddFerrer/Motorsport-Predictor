package com.motorsport_predictor.users_service.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

import java.util.Set;

@Getter
@Setter
public class CreateUserDTO {
    @NotEmpty(message = "Required field")
    @NotNull
    @Length(min = 5, max = 32, message = "must have between 6 and 32 characters")
    private String username;

    @NotEmpty(message = "Required field")
    @NotNull
    private String firstName;

    @NotEmpty(message = "Required field")
    @NotNull
    private String lastName;

    @NotEmpty(message = "Required field")
    @NotNull
    private String nationality;

    @Email
    @NotEmpty(message = "Required field")
    @NotNull
    private String email;

    @NotEmpty(message = "Required field")
    @NotNull
    @Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{5,32}$",
            message = "The password must be at least 5 characters long and include a lowercase letter, an uppercase letter, a number, and a special character.")
    @Length(min = 5, max = 32, message = "must have between 6 and 32 characters")
    private String password;

    private Set<String> roles;
}