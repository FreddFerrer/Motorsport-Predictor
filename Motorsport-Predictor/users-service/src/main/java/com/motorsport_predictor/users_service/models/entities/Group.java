package com.motorsport_predictor.users_service.models.entities;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "groups")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Group {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column
    private String description;

    @Column(name = "is_public")
    private boolean isPublic;

    @Column(name = "is_official")
    private boolean isOfficial;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Column(name = "creator_id")
    private String creatorId;

    @Column
    private String discipline;

    @OneToMany(mappedBy = "group")
    private List<GroupMember> members = new ArrayList<>();
}
