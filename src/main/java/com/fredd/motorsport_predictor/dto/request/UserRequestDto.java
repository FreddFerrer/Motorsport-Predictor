package com.fredd.motorsport_predictor.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

@Getter
@Setter
public class UserRequestDto {
    private int id;
    @NotEmpty(message = "Required field")
    @NotNull
    @Length(min = 5, max = 32, message = "must have between 6 and 32 characters")
    private String username;

    @NotEmpty(message = "Required field")
    @NotNull
    private String firstName;

    @NotEmpty(message = "Required field")
    @NotNull
    private String secondName;

    @NotEmpty(message = "Required field")
    @NotNull
    private String userNationality;

    @Email
    @NotEmpty(message = "Required field")
    @NotNull
    private String userEmail;

    @NotEmpty(message = "Required field")
    @NotNull
    @Pattern(regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{5,32}$",
            message = "The password must be at least 5 characters long and include a lowercase letter, an uppercase letter, a number, and a special character.")
    @Length(min = 5, max = 32, message = "must have between 6 and 32 characters")
    private String userPassword;
}
