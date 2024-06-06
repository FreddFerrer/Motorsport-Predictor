package com.fredd.motorsport_predictor.models.mappers;

import com.fredd.motorsport_predictor.dto.UserDto;
import com.fredd.motorsport_predictor.dto.request.UserRequestDto;
import com.fredd.motorsport_predictor.models.entities.User;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface IUserDtoMapper {
    UserDto toDto(User user);

    User toEntity(UserRequestDto usuario);
}
