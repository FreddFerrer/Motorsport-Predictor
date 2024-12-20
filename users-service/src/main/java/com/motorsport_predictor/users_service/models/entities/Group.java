package com.motorsport_predictor.users_service.models.entities;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "`groups`")
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Group {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = true)
    private String description;

    @Column(name = "is_public", nullable = false)
    @JsonProperty("isPublic")
    private boolean isPublic;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @Column(name = "creator_id", nullable = false)
    private String creatorId;

    @Column(name = "is_official", nullable = false)
    private boolean isOfficial;

    @Column(nullable = false, length = 50)
    private String discipline;

    @Column(name = "member_count")
    private Integer memberCount;
    @OneToMany(mappedBy = "group")
    private List<GroupMember> members = new ArrayList<>();

    @Transient
    public int getMemberCount() {
        return members.size(); // Acceso directo al tamaño de la colección
    }

    public Group(Long id, String name, String description, boolean isPublic, LocalDateTime createdAt, LocalDateTime updatedAt, String creatorId, boolean isOfficial, String discipline, Integer memberCount) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.isPublic = isPublic;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.creatorId = creatorId;
        this.isOfficial = isOfficial;
        this.discipline = discipline;
        this.memberCount = memberCount;
    }
}
