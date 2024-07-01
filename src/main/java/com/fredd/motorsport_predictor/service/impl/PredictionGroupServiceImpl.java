package com.fredd.motorsport_predictor.service.impl;

import com.fredd.motorsport_predictor.dto.response.PredictionGroupDto;
import com.fredd.motorsport_predictor.dto.request.PredictionGroupRequestDto;
import com.fredd.motorsport_predictor.enums.DisciplineEnum;
import com.fredd.motorsport_predictor.exceptions.BadRequestException;
import com.fredd.motorsport_predictor.models.entities.Discipline;
import com.fredd.motorsport_predictor.models.entities.PredictionGroup;
import com.fredd.motorsport_predictor.models.entities.User;
import com.fredd.motorsport_predictor.models.mappers.IPredictionGroupMapper;
import com.fredd.motorsport_predictor.repositories.IDisciplineRepository;
import com.fredd.motorsport_predictor.repositories.IPredictionGroupRepository;
import com.fredd.motorsport_predictor.repositories.IUserRepository;
import com.fredd.motorsport_predictor.service.IPredictionGroupService;
import lombok.RequiredArgsConstructor;
import org.hibernate.Hibernate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PredictionGroupServiceImpl implements IPredictionGroupService {

    private final IPredictionGroupRepository iPredictionGroupRepository;
    private final IDisciplineRepository iDisciplineRepository;
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
        // Obtener el usuario autenticado
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User userCreator = (User) authentication.getPrincipal();

        // Obtener la disciplina ingresada por el usuario
        DisciplineEnum disciplineEnum = predictionGroupRequestDto.getDiscipline();
        Optional<Discipline> optionalDiscipline = iDisciplineRepository.findByDisciplineName(disciplineEnum);

        if (optionalDiscipline.isPresent()) {
            Discipline discipline = optionalDiscipline.get();

            // Crear un nuevo grupo de predicción
            PredictionGroup newPredictionGroup = PredictionGroup.builder()
                    .creator(userCreator)
                    .groupName(predictionGroupRequestDto.getGroupName())
                    .isOficial(false)
                    .discipline(discipline)
                    .build();

            // Guardar
            iPredictionGroupRepository.save(newPredictionGroup);

            return iPredictionGroupMapper.toDto(newPredictionGroup);
        } else {
            throw new BadRequestException("Discipline doesn't exist");
        }
    }

    //To be completed
    @Override
    public Optional<PredictionGroupDto> editPredictionGroup(Long id, PredictionGroupRequestDto predictionGroupRequestDto) {

        Optional<PredictionGroup> optionalPredictionGroup = iPredictionGroupRepository.findById(id);

        if (optionalPredictionGroup.isPresent()) {
            PredictionGroup predictionGroup = optionalPredictionGroup.get();

            // Buscar la disciplina correspondiente al enum proporcionado en el DTO
            DisciplineEnum disciplineEnum = predictionGroupRequestDto.getDiscipline();
            Optional<Discipline> optionalDiscipline = iDisciplineRepository.findByDisciplineName(disciplineEnum);
            if (optionalDiscipline.isPresent()) {
                Discipline discipline = optionalDiscipline.get();

                // Actualizar campos
                predictionGroup.setGroupName(predictionGroupRequestDto.getGroupName());
                predictionGroup.setDiscipline(discipline);

                // Guardar cambios
                PredictionGroup updatedPredictionGroup = iPredictionGroupRepository.save(predictionGroup);

                // Convertir entidad a DTO
                PredictionGroupDto predictionGroupDto = iPredictionGroupMapper.toDto(updatedPredictionGroup);

                return Optional.ofNullable(predictionGroupDto);
            } else {
                throw new BadRequestException("Discipline doesn't exist");
            }
        } else {
            throw new BadRequestException("Prediction group doesn't exist");
        }
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
