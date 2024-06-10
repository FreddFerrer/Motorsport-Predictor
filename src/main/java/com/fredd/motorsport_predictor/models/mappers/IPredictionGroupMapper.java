package com.fredd.motorsport_predictor.models.mappers;

import com.fredd.motorsport_predictor.dto.PredictionGroupDto;
import com.fredd.motorsport_predictor.dto.request.PredictionGroupRequestDto;
import com.fredd.motorsport_predictor.models.entities.PredictionGroup;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface IPredictionGroupMapper {

    PredictionGroupDto toDto(PredictionGroup predictionGroup);

    PredictionGroup toEntity(PredictionGroupRequestDto usuario);

}
