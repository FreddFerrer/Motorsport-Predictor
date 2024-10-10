package com.motorsport_predictor.users_service.controllers;

import com.motorsport_predictor.users_service.dto.request.AddMemberByIdDTO;
import com.motorsport_predictor.users_service.dto.request.AddMemberByUsernameDTO;
import com.motorsport_predictor.users_service.dto.request.CreateGroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupDTO;
import com.motorsport_predictor.users_service.dto.response.GroupMemberDTO;
import com.motorsport_predictor.users_service.exceptions.BadRequestException;
import com.motorsport_predictor.users_service.service.IGroupMemberService;
import com.motorsport_predictor.users_service.service.IGroupService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/groups")
@RequiredArgsConstructor
public class GroupController {
    private final IGroupService groupService;
    private final IGroupMemberService groupMemberService;

    @Operation(
            summary = "Obtener una lista paginada de grupos",
            description = "Este endpoint devuelve una lista de grupos paginada, mostrando hasta 10 resultados por página de manera predeterminada. No requiere autenticación.",
            responses = {
                    @ApiResponse(responseCode = "200", description = "Lista paginada de grupos devuelta exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupDTO.class))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Bad request",
                    "path": "uri=/api/groups"
                }
            """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Internal server error",
                    "path": "uri=/api/groups"
                }
            """)))
            }
    )
    @GetMapping("/")
    public ResponseEntity<?> getAllGroups(@PageableDefault(size = 10) @Parameter(hidden = true) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupService.getAllGroups(pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Obtener un grupo por ID (solo accesible para ROLE_ADMIN)",
            description = "Este endpoint devuelve un grupo específico por su ID, pero solo puede ser accedido por usuarios con el rol 'ROLE_ADMIN'.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Grupo devuelto exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupDTO.class))),
                    @ApiResponse(responseCode = "404", description = "Grupo no encontrado",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Resource group 56 not found.",
                    "path": "uri=/api/groups/56"
                }
            """))),
                    @ApiResponse(responseCode = "403", description = "Acceso prohibido (no tiene el rol adecuado)",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Access is denied",
                    "path": "uri=/api/groups/56"
                }
            """))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Bad request",
                    "path": "uri=/api/groups/56"
                }
            """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Internal server error",
                    "path": "uri=/api/groups/56"
                }
            """)))
            }
    )
    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<?> getGroupById(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(groupService.getGroupById(id));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Obtener un grupo por su nombre",
            description = "Este endpoint devuelve un grupo específico por su nombre completo, puede ser accedido por usuarios con el rol 'ROLE_ADMIN' y 'ROLE_USER'.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Grupo devuelto exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupDTO.class))),
                    @ApiResponse(responseCode = "404", description = "Grupo no encontrado",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Resource group 'Formula 4' not found.",
                    "path": "uri=/api/groups/byName/'Formula 4'"
                }
            """))),
                    @ApiResponse(responseCode = "403", description = "Acceso prohibido (requiere autenticacion)",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Access is denied",
                    "path": "uri=/api/groups/byName/'Formula 4'"
                }
            """))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Bad request",
                    "path": "uri=/api/groups/byName/'Formula 4'"
                }
            """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                {
                    "message": "Internal server error",
                    "path": "uri=/api/groups/byName/'Formula 4'"
                }
            """)))
            }
    )
    @GetMapping("/byName/{name}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupByName(@PathVariable String name) {
        try {
            return ResponseEntity.ok(groupService.getGroupByName(name));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    // return all the groups by User logged
    @Operation(
            summary = "Obtener grupos del usuario logueado",
            description = "Este endpoint devuelve todos los grupos a los que pertenece el usuario autenticado. El usuario debe tener el rol 'ROLE_USER' para acceder a este endpoint.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Grupos devueltos exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupDTO.class))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta o el usuario no pertenece a ningún grupo",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "User a5b733dd-0ce3-4a92-82d7-69a4e9cf2ec1 is not a member of any group",
                "path": "uri=/api/groups/byUser"
            }
        """))),
                    @ApiResponse(responseCode = "403", description = "Acceso prohibido (requiere autenticación)",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Access is denied",
                "path": "uri=/api/groups/byUser"
            }
        """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Internal server error",
                "path": "uri=/api/groups/byUser"
            }
        """)))
            }
    )
    @GetMapping("/byUser")
    @PreAuthorize("hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupByUser(@PageableDefault(size = 10) @Parameter(hidden = true) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupMemberService.getGroupsByUser(pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Obtener grupos por disciplina",
            description = "Este endpoint devuelve todos los grupos pertenecientes a una Disciplina. Lo pueden acceder 'ROLE_USER' y 'ROLE_ADMIN'.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Grupos devueltos exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupDTO.class))),
                    @ApiResponse(responseCode = "400", description = "La disciplina ingresada no existe",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Resource 'Formula 4' not found.",
                "path": "uri=/api/groups/byDiscipline/'Formula 4'"
            }
        """))),
                    @ApiResponse(responseCode = "403", description = "Acceso prohibido (requiere autenticación)",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Access is denied",
                "path": "uri=/api/groups/byDiscipline/'Formula 4'"
            }
        """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Internal server error",
                "path": "uri=/api/groups/byDiscipline/'Formula 4'"
            }
        """)))
            }
    )
    @GetMapping("/byDiscipline/{discipline}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupByDiscipline(@PathVariable String discipline, @PageableDefault(size = 10) @Parameter(hidden = true) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupService.getGroupsByDiscipline(discipline, pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Obtener los grupos mas populares",
            description = "Este endpoint devuelve una lista de los 10 grupos mas populares (los que tienen mas integrantes). Enpoint público.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Grupos devueltos exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupDTO.class))),

                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Internal server error",
                "path": "uri=/api/groups/byDiscipline/'Formula 4'"
            }
        """)))
            }
    )
    @GetMapping("/populars")
    public ResponseEntity<?> getPopularGroups() {
        try {
            return ResponseEntity.ok(groupService.getPopularGroups());
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Buscador de grupos por cualquier concepto (nombre o descripción)",
            description = "Este endpoint devuelve una lista de los grupos encontrados por su nombre o descripcion. Enpoint público.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Grupos devueltos exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupDTO.class))),

                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Internal server error",
                "path": "uri=/api/groups/byDiscipline/'Formula 4'"
            }
        """)))
            }
    )
    @GetMapping("/search/{searchTerm}")
    public ResponseEntity<?> searchGroups(@PathVariable String searchTerm, @PageableDefault(size = 10) @Parameter(hidden = true) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupService.searchGroups(searchTerm, pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Obtener miembros de un grupo por ID",
            description = "Este endpoint devuelve una lista de los miembros de un grupo específico, basado en el ID del grupo. El resultado se puede paginar. Si el grupo no existe, se devuelve un mensaje de error. El endpoint es público y no requiere autenticación.",
            responses = {
                    @ApiResponse(responseCode = "200", description = "Lista de miembros del grupo devuelta exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupMemberDTO.class))),
                    @ApiResponse(responseCode = "404", description = "Grupo no encontrado",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Resource group 4 not found.",
                "path": "uri=/api/groups/4/members"
            }
        """))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Bad request",
                "path": "uri=/api/groups/4/members"
            }
        """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Internal server error",
                "path": "uri=/api/groups/4/members"
            }
        """)))
            }
    )
    @GetMapping("/{groupId}/members")
    public ResponseEntity<?> getMembersByGroup(@PathVariable Long groupId, @PageableDefault(size = 10) @Parameter(hidden = true) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupMemberService.getMembersByGroupId(groupId, pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Obtener grupos por ID de usuario",
            description = "Este endpoint devuelve una lista de grupos en los que el usuario (especificado por su ID) es miembro. El resultado se puede paginar. Los usuarios deben tener el rol 'ROLE_ADMIN' o 'ROLE_USER' para acceder a este endpoint.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Lista de grupos del usuario devuelta exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupDTO.class))),
                    @ApiResponse(responseCode = "404", description = "Usuario no encontrado o ID de usuario incorrecto",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Resource 1118d324-b46c-48ef-ac01-01da1404ae85 not found.",
                "path": "uri=/api/groups/byUserId/1118d324-b46c-48ef-ac01-01da1404ae85"
            }
        """))),
                    @ApiResponse(responseCode = "404", description = "Usuario no pertenece a ningún grupo",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "User 16c02d7a-c978-4551-a3f5-1a14e1536dd3 is not a member of any group",
                "path": "uri=/api/groups/byUserId/16c02d7a-c978-4551-a3f5-1a14e1536dd3"
            }
        """))),
                    @ApiResponse(responseCode = "403", description = "Acceso prohibido (requiere autenticación)",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Access is denied",
                "path": "uri=/api/groups/byUserId/{userId}"
            }
        """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Internal server error",
                "path": "uri=/api/groups/byUserId/{userId}"
            }
        """)))
            }
    )
    @GetMapping("/byUserId/{userId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupsByUserId(@PathVariable String userId, @PageableDefault(size = 10) @Parameter(hidden = true) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupMemberService.getGroupsByUserId(userId, pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Obtener grupos por USERNAME de usuario",
            description = "Este endpoint devuelve una lista de grupos en los que el usuario especificado por su username es miembro. El resultado se puede paginar. Los usuarios deben tener el rol 'ROLE_ADMIN' o 'ROLE_USER' para acceder a este endpoint.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "200", description = "Lista de grupos del usuario devuelta exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupDTO.class))),
                    @ApiResponse(responseCode = "404", description = "Usuario no encontrado o username de usuario incorrecto",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Resource 1118d324-b46c-48ef-ac01-01da1404ae85 not found.",
                "path": "uri=/api/groups/byUserId/1118d324-b46c-48ef-ac01-01da1404ae85"
            }
        """))),
                    @ApiResponse(responseCode = "404", description = "Usuario no pertenece a ningún grupo",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "User 16c02d7a-c978-4551-a3f5-1a14e1536dd3 is not a member of any group",
                "path": "uri=/api/groups/byUserId/16c02d7a-c978-4551-a3f5-1a14e1536dd3"
            }
        """))),
                    @ApiResponse(responseCode = "403", description = "Acceso prohibido (requiere autenticación)",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Access is denied",
                "path": "uri=/api/groups/byUserId/{userId}"
            }
        """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
            {
                "message": "Internal server error",
                "path": "uri=/api/groups/byUserId/{userId}"
            }
        """)))
            }
    )
    @GetMapping("/byUsername/{username}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> getGroupsByUsername(@PathVariable String username, @PageableDefault(size = 10) @Parameter(hidden = true) Pageable pageable) {
        try {
            return ResponseEntity.ok(groupMemberService.getGroupsByUsername(username, pageable));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    // Intern endpoint
    @Operation(hidden = true)
    @GetMapping("/existUserInGroup/{groupId}/{userId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> existUserInGroup(@PathVariable Long groupId, @PathVariable String userId) {
        try {
            return ResponseEntity.ok(groupMemberService.isUserInGroup(groupId, userId));
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Crear un nuevo grupo",
            description = "Este endpoint permite a los usuarios con el rol 'ROLE_ADMIN' o 'ROLE_USER' crear un nuevo grupo. Se debe proporcionar un objeto JSON con los detalles del grupo. El grupo creado se devuelve en la respuesta. Se requiere autenticación para acceder a este endpoint.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    content = @Content(mediaType = "application/json",
                            schema = @Schema(implementation = CreateGroupDTO.class),
                            examples = @ExampleObject(value = """
        {
            "name": "New Group",
            "description": "A description of the new group.",
            "discipline": "Formula 2",
            "isPublic": true
        }
    """))),
            responses = {
                    @ApiResponse(responseCode = "201", description = "Grupo creado exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(implementation = GroupDTO.class))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Bad request",
            "path": "uri=/api/groups/create"
        }
    """))),
                    @ApiResponse(responseCode = "403", description = "Acceso prohibido (requiere autenticación)",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Access is denied",
            "path": "uri=/api/groups/create"
        }
    """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Internal server error",
            "path": "uri=/api/groups/create"
        }
    """)))
            }
    )
    @PostMapping("/create")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> createGroup(@RequestBody @Valid CreateGroupDTO createGroupDTO) {
        try {
            GroupDTO group = groupService.createNewGroup(createGroupDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(group);
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Agregar un nuevo miembro a un grupo por ID",
            description = "Este endpoint permite agregar un nuevo miembro a un grupo específico pasandole el ID del usuario. Solo el creador del grupo puede realizar esta operación. Se requiere autenticación para acceder a este endpoint.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    content = @Content(mediaType = "application/json",
                            schema = @Schema(implementation = AddMemberByIdDTO.class),
                            examples = @ExampleObject(value = """
        {
            "userId": "b17f0056-d845-469c-a685-c044c9f1296e"
        }
    """))),
            responses = {
                    @ApiResponse(responseCode = "201", description = "Miembro agregado exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(type = "string", example = "successfully"))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Error adding member",
            "path": "uri=/api/groups/1/newMemberId"
        }
    """))),
                    @ApiResponse(responseCode = "403", description = "Acceso prohibido (solo el creador puede agregar miembros)",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Only the creator of the group can add members.",
            "path": "uri=/api/groups/1/newMemberId"
        }
    """))),
                    @ApiResponse(responseCode = "404", description = "Grupo o usuario no encontrado",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Group with ID 1 not found",
            "path": "uri=/api/groups/1/newMemberId"
        }
    """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Internal server error",
            "path": "uri=/api/groups/1/newMemberId"
        }
    """)))
            }
    )
    @PostMapping("/{groupId}/newMemberId")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> addMemberById(@PathVariable Long groupId, @RequestBody @Valid AddMemberByIdDTO newMemberToGroupDTO) {
        try {
            groupMemberService.addMemberToGroupById(groupId, newMemberToGroupDTO.getUserId());
            return ResponseEntity.status(HttpStatus.CREATED).body("successfully");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Agregar un nuevo miembro a un grupo por su USERNAME",
            description = "Este endpoint permite agregar un nuevo miembro a un grupo específico pasandole el USERNAME del usuario. Solo el creador del grupo puede realizar esta operación. Se requiere autenticación para acceder a este endpoint.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    content = @Content(mediaType = "application/json",
                            schema = @Schema(implementation = AddMemberByIdDTO.class),
                            examples = @ExampleObject(value = """
        {
            "username": "usuario_prueba_2"
        }
    """))),
            responses = {
                    @ApiResponse(responseCode = "201", description = "Miembro agregado exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(type = "string", example = "successfully"))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                            {
                                "message": "You cannot add yourself to the group.",
                                "path": "uri=/api/groups/1/newMemberUsername"
                            }
                    """))),
                    @ApiResponse(responseCode = "403", description = "Acceso prohibido (solo el creador puede agregar miembros)",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                            {
                                "message": "Access denied.",
                                "path": "uri=/api/groups/1/newMemberUsername"
                            }
                    """))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                            {
                                "message": "Only the creator of the group can add members.",
                                "path": "uri=/api/groups/1/newMemberUsername"
                            }
                    """))),
                    @ApiResponse(responseCode = "404", description = "Grupo o usuario no encontrado",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                            {
                                "message": "Group with ID 1 not found",
                                "path": "uri=/api/groups/1/newMemberUsername"
                            }
                    """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
                            {
                                "message": "Internal server error",
                                "path": "uri=/api/groups/1/newMemberUsername"
                            }
                    """)))
            }
    )
    @PostMapping("/{groupId}/newMemberUsername")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> addMemberByUsername(@PathVariable Long groupId, @RequestBody AddMemberByUsernameDTO newMemberByUsernameDTO) {
        try {
            groupMemberService.addMemberToGroupByUsername(groupId, newMemberByUsernameDTO.getUsername());
            return ResponseEntity.status(HttpStatus.CREATED).body("successfully");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Eliminar un grupo por ID",
            description = "Este endpoint permite eliminar un grupo específico por su ID. Solo el creador del grupo puede realizar esta acción. Se requiere autenticación para acceder a este endpoint.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "204", description = "Grupo eliminado exitosamente",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(type = "string", example = "Group deleted successfully"))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Only the creator of the group can delete the group.",
            "path": "uri=/api/groups/1"
        }
    """))),
                    @ApiResponse(responseCode = "404", description = "Grupo no encontrado",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Group with ID 1 not found",
            "path": "uri=/api/groups/1"
        }
    """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Internal server error",
            "path": "uri=/api/groups/1"
        }
    """)))
            }
    )
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> deleteGroupById(@PathVariable Long id) {
        try {
            groupService.deleteGroupById(id);
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body("Group deleted successfully");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }

    @Operation(
            summary = "Eliminar un miembro de un grupo por ID",
            description = "Este endpoint permite eliminar un miembro específico de un grupo por el ID del grupo y el ID del usuario. Solo el creador del grupo puede realizar esta acción. Se requiere autenticación para acceder a este endpoint.",
            security = @SecurityRequirement(name = "Bearer Authentication"),
            responses = {
                    @ApiResponse(responseCode = "204", description = "Miembro eliminado exitosamente del grupo",
                            content = @Content(mediaType = "application/json",
                                    schema = @Schema(type = "string", example = "User removed from group"))),
                    @ApiResponse(responseCode = "400", description = "Solicitud incorrecta",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "The group founder cannot delete himself :)",
            "path": "uri=/api/groups/1/deleteMember/12345"
        }
    """))),
                    @ApiResponse(responseCode = "403", description = "Acceso prohibido",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Only the group founder can remove members",
            "path": "uri=/api/groups/1/deleteMember/12345"
        }
    """))),
                    @ApiResponse(responseCode = "404", description = "Miembro o grupo no encontrado",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "User 12345 is not a member of group 1",
            "path": "uri=/api/groups/1/deleteMember/12345"
        }
    """))),
                    @ApiResponse(responseCode = "500", description = "Error interno del servidor",
                            content = @Content(mediaType = "application/json",
                                    examples = @ExampleObject(value = """
        {
            "message": "Internal server error",
            "path": "uri=/api/groups/1/deleteMember/12345"
        }
    """)))
            }
    )
    @DeleteMapping("/{groupId}/deleteMember/{userId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<?> deleteMemberFromGroupById(@PathVariable Long groupId, @PathVariable String userId) {
        try {
            groupMemberService.removeMemberFromGroupById(groupId, userId);

            return ResponseEntity.status(HttpStatus.NO_CONTENT).body("User removed from group");
        } catch (Exception e) {
            throw new BadRequestException(e.getMessage());
        }
    }
}