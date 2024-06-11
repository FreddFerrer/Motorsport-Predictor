package com.fredd.motorsport_predictor.service.impl;

import com.fredd.motorsport_predictor.dto.response.PredictionGroupDto;
import com.fredd.motorsport_predictor.dto.request.PredictionGroupRequestDto;
import com.fredd.motorsport_predictor.exceptions.BadRequestException;
import com.fredd.motorsport_predictor.models.entities.PredictionGroup;
import com.fredd.motorsport_predictor.models.entities.User;
import com.fredd.motorsport_predictor.models.mappers.IPredictionGroupMapper;
import com.fredd.motorsport_predictor.repositories.IPredictionGroupRepository;
import com.fredd.motorsport_predictor.repositories.IUserRepository;
import com.fredd.motorsport_predictor.service.IPredictionGroupService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PredictionGroupServiceImpl implements IPredictionGroupService {

    private final IPredictionGroupRepository iPredictionGroupRepository;
    private final IUserRepository iUserRepository;
    private final IPredictionGroupMapper iPredictionGroupMapper;

    @Override
    public List<PredictionGroupDto> getAllPredictionGroup() {
        List<PredictionGroup> predictionGroups = iPredictionGroupRepository.findAll();

        return predictionGroups.stream().map(iPredictionGroupMapper::toDto).collect(Collectors.toList());
    }

    @Override
    public Optional<PredictionGroupDto> getPredictionGroupById(Long id) {
        return iPredictionGroupRepository.findById(id).map(iPredictionGroupMapper::toDto);
    }

    @Override
    public Optional<PredictionGroupDto> getPredictionGroupByUser(Long userCreatorId) {
        Optional<User> userCreatorOptional = iUserRepository.findById(userCreatorId);
        User userCreator = new User();

        if (userCreatorOptional.isPresent()) {
            userCreator = userCreatorOptional.get();
        }
        if (userCreatorOptional == null) {
            throw new BadRequestException("Invalid user");
        }

        return iPredictionGroupRepository.findByCreator(userCreator).map(iPredictionGroupMapper::toDto);
    }

    @Override
    public PredictionGroupDto savePredictionGroup(PredictionGroupRequestDto predictionGroupRequestDto) {
        PredictionGroup newPredictionGroup = iPredictionGroupMapper.toEntity(predictionGroupRequestDto);
        iPredictionGroupRepository.save(newPredictionGroup);
        return iPredictionGroupMapper.toDto(newPredictionGroup);
    }

    //To be completed
    @Override
    public Optional<PredictionGroupDto> editPredictionGroup(PredictionGroupRequestDto predictionGroupRequestDto) {
        if (iPredictionGroupRepository.findById(predictionGroupRequestDto.getId()).isEmpty()) {
            return Optional.empty();
        }
        PredictionGroup newPredictionGroup = iPredictionGroupMapper.toEntity(predictionGroupRequestDto);
        iPredictionGroupRepository.save(newPredictionGroup);
        return Optional.of(iPredictionGroupMapper.toDto(newPredictionGroup));
    }

    //To be completed
    @Override
    public Boolean deletePredictionGroup(Long id) {
        if (iPredictionGroupRepository.findById(id).isEmpty()) {
            return false;
        }

        iPredictionGroupRepository.deleteById(id);
        return true;
    }
}
