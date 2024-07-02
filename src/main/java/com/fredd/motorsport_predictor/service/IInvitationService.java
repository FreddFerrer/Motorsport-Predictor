package com.fredd.motorsport_predictor.service;

import com.fredd.motorsport_predictor.dto.request.SignUpRequestDto;
import com.fredd.motorsport_predictor.dto.response.UserDto;
import com.fredd.motorsport_predictor.models.entities.Invitation;

import java.util.List;
import java.util.Optional;

public interface IInvitationService {

    List<Invitation> getAllInvitations();

    Optional<Invitation> getInvitationById(Long id);

    Optional<Invitation> getInvitationByUser();

    Optional<Invitation> getInvitationByPredictionGroup();

    UserDto saveUser(SignUpRequestDto userRequest);

    Optional<UserDto> editUser(UserDto userDto);

    Boolean deleteUser(Long userId);
}
