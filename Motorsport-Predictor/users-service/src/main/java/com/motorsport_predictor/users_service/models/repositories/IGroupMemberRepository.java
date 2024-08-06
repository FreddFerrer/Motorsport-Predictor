package com.motorsport_predictor.users_service.models.repositories;

import com.motorsport_predictor.users_service.models.entities.GroupMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IGroupMemberRepository extends JpaRepository<GroupMember, Long> {


}