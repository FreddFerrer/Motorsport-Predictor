package com.fredd.motorsport_predictor.service.impl;

import com.fredd.motorsport_predictor.dto.request.SignUpRequestDto;
import com.fredd.motorsport_predictor.dto.response.UserDto;
import com.fredd.motorsport_predictor.models.entities.Invitation;
import com.fredd.motorsport_predictor.service.IInvitationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class InvitationServiceImpl implements IInvitationService {

    @Override
    public List<Invitation> getAllInvitations() {
        return List.of();
    }

    @Override
    public Optional<Invitation> getInvitationById(Long id) {
        return Optional.empty();
    }

    @Override
    public Optional<Invitation> getInvitationByUser() {
        return Optional.empty();
    }

    @Override
    public Optional<Invitation> getInvitationByPredictionGroup() {
        return Optional.empty();
    }

    @Override
    public UserDto saveUser(SignUpRequestDto userRequest) {
        return null;
    }

    @Override
    public Optional<UserDto> editUser(UserDto userDto) {
        return Optional.empty();
    }

    @Override
    public Boolean deleteUser(Long userId) {
        return null;
    }
}
