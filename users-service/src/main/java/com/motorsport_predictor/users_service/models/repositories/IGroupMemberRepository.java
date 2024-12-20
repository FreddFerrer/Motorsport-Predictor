package com.motorsport_predictor.users_service.models.repositories;

import com.motorsport_predictor.users_service.models.entities.Group;
import com.motorsport_predictor.users_service.models.entities.GroupMember;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface IGroupMemberRepository extends JpaRepository<GroupMember, Long> {
    Optional<GroupMember> findByGroupIdAndUserId(Long groupId, String userId);
    @Query("SELECT gm.userId, gm.joinedAt FROM GroupMember gm WHERE gm.group.id = :groupId")
    Page<Object[]> findUserIdAndJoinedAtByGroupId(@Param("groupId") Long groupId, Pageable pageable);
    @Query("SELECT gm.group.id FROM GroupMember gm WHERE gm.userId = :userId")
    List<Long> findGroupIdsByUserId(@Param("userId") String userId);
    boolean existsByGroupAndUserId(Group group, String userId);
    boolean existsByUserIdAndGroupId(String userId, Long groupId);
}