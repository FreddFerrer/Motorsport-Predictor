package com.fredd.motorsport_predictor.models.mappers;

import com.fredd.motorsport_predictor.dto.response.UserDto;
import com.fredd.motorsport_predictor.dto.request.SignUpRequestDto;
import com.fredd.motorsport_predictor.models.entities.User;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface IUserDtoMapper {
    UserDto toDto(User user);

    User toEntity(SignUpRequestDto usuario);

    User toEntity(UserDto userDto);
}
