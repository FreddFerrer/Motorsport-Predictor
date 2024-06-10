package com.fredd.motorsport_predictor.service.impl;

import com.fredd.motorsport_predictor.dto.response.PredictionGroupDto;
import com.fredd.motorsport_predictor.dto.request.PredictionGroupRequestDto;
import com.fredd.motorsport_predictor.models.entities.PredictionGroup;
import com.fredd.motorsport_predictor.models.mappers.IPredictionGroupMapper;
import com.fredd.motorsport_predictor.repositories.IPredictionGroupRepository;
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
    public Optional<PredictionGroupDto> getPredictionGroupByUser(String userCreator) {
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
    public PredictionGroupDto editPredictionGroup(PredictionGroupRequestDto predictionGroupRequestDto) {
        return null;
    }

    //To be completed
    @Override
    public void deletePredictionGroup(Long id) {

    }
}
