package com.fredd.motorsport_predictor.repositories;

import com.fredd.motorsport_predictor.models.entities.Invitation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IInvitationRepository extends JpaRepository<Invitation, Long> {
}
