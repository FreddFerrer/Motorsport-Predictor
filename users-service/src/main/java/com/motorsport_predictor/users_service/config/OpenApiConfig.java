package com.motorsport_predictor.users_service.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;


@Configuration
@OpenAPIDefinition(
        info = @io.swagger.v3.oas.annotations.info.Info(
                title = "Users Service",
                version = "1.0.0",
                description = """
            ## Documentación F1 Service v1.0
            
            #### Información importante
            Este microservicio se encarga de la administración de los usuarios y grupos de predicciones.
            Un usuario puede crear/eliminar un grupo de predicción y agregar/eliminar a usuarios buscándolos por su username o id.
            También nos permite ver cuales son los grupos mas populares teniendo en cuenta el numero de sus miembros.
            Incluye todos los endpoints relacionados con la búsqueda de los grupos (por nombre, id y descripción).
            
            ### Datos Iniciales

            #### Grupos:
            - **ID:** 1
              **Nombre:** Formula 1 NO oficial privado
              **Descripción:** Grupo NO oficial y privado de F1 para predecir resultados
              **Público:** No
              **Fecha de creación:** 2024-09-09
              **Creador:** usuario_prueba_1 (ID: 1118d324-b46c-48ef-ac01-01da1404ae84)
              **Disciplina:** Formula 1

            - **ID:** 2
              **Nombre:** IndyCar oficial
              **Descripción:** Grupo oficial de IndyCar
              **Público:** Sí
              **Fecha de creación:** 2024-09-09
              **Creador:** usuario_prueba_1 (ID: 1118d324-b46c-48ef-ac01-01da1404ae84)
              **Disciplina:** IndyCar

            #### Miembros de los Grupos:
            - **Grupo 1:** usuario_prueba_1, usuario_prueba_2
            
            - **Grupo 2:** usuario_prueba_1, usuario_prueba_3, usuario_prueba_4 , usuario_prueba_5

            #### ID Usuarios:
            - **usuario_prueba_1:** 1118d324-b46c-48ef-ac01-01da1404ae84
            - **usuario_prueba_2:** b17f0056-d845-469c-a685-c044c9f1296e
            - **usuario_prueba_3:** 46cdb783-cbca-4163-8df2-5071d1714110
            - **usuario_prueba_4:** ea0b0853-ade4-49ad-8c8a-8da431f57809
            - **usuario_prueba_5:** e420c351-da7f-44ef-beec-56ce812a599f
            """
        )
)public class OpenApiConfig {
    @Bean
    public OpenAPI customOpenAPI(
            @Value("${openapi.service.title}") String serviceTitle,
            @Value("${openapi.service.version}") String serviceVersion,
            @Value("${openapi.service.url}") String url) {
        final String securitySchemeName = "Bearer Authentication";
        return new OpenAPI()
                .servers(List.of(new Server().url(url)))
                .components(
                        new Components()
                                .addSecuritySchemes(
                                        securitySchemeName,
                                        new SecurityScheme()
                                                .type(SecurityScheme.Type.HTTP)
                                                .scheme("bearer")
                                                .bearerFormat("JWT")))
                .info(new Info().title(serviceTitle).version(serviceVersion));
    }
}
