package com.motorsport_predictor.f1_service.config;

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
                title = "F1 Service",
                version = "1.0.0",
                description = "F1 Service v1.0.0 proporciona información sobre las carreras de Fórmula 1, incluyendo circuitos, pilotos, equipos y resultados de las carreras. Este microservicio ofrece endpoints para consultar y administrar datos relacionados con las competiciones de Fórmula 1.\n\n" +
                        "Después de realizar el login, los usuarios deben obtener el **access_token** y pegarlo en el campo correspondiente de Swagger para acceder a los endpoints protegidos.\n\n" +
                        "**Datos Iniciales Incluidos** (solo algunos de ejemplo):\n\n" +
                        "**Circuits**:\n" +
                        "- **ID**: 17, **Name**: Baku City Circuit, **Location**: Baku, Azerbaijan\n" +
                        "- **ID**: 18, **Name**: Marina Bay Street Circuit, **Location**: Marina Bay, Singapore\n" +
                        "- **ID**: 19, **Name**: Circuit of the Americas, **Location**: Austin, USA\n" +
                        "- **ID**: 20, **Name**: Autódromo Hermanos Rodríguez, **Location**: Mexico City, Mexico\n" +
                        "- **ID**: 21, **Name**: Autódromo José Carlos Pace, **Location**: São Paulo, Brazil\n" +
                        "- **ID**: 22, **Name**: Las Vegas Strip Street Circuit, **Location**: Las Vegas, United States\n" +
                        "- **ID**: 23, **Name**: Losail International Circuit, **Location**: Al Daayen, Qatar\n" +
                        "- **ID**: 24, **Name**: Yas Marina Circuit, **Location**: Abu Dhabi, UAE\n\n" +
                        "**Drivers**:\n" +
                        "- **ID**: 1, **Name**: Max Verstappen, **Country**: Netherlands, **Team ID**: 1\n" +
                        "- **ID**: 2, **Name**: Lando Norris, **Country**: United Kingdom, **Team ID**: 2\n" +
                        "- **ID**: 3, **Name**: Charles Leclerc, **Country**: Monaco, **Team ID**: 3\n" +
                        "- **ID**: 4, **Name**: Oscar Piastri, **Country**: Australia, **Team ID**: 2\n" +
                        "- **ID**: 5, **Name**: Carlos Sainz, **Country**: Spain, **Team ID**: 3\n" +
                        "- **ID**: 6, **Name**: Lewis Hamilton, **Country**: United Kingdom, **Team ID**: 4\n" +
                        "- **ID**: 7, **Name**: Sergio Perez, **Country**: Mexico, **Team ID**: 1\n" +
                        "- **ID**: 8, **Name**: George Russell, **Country**: United Kingdom, **Team ID**: 4\n" +
                        "- **ID**: 9, **Name**: Fernando Alonso, **Country**: Spain, **Team ID**: 5\n" +
                        "- **ID**: 10, **Name**: Lance Stroll, **Country**: Canada, **Team ID**: 5\n\n" +
                        "**Teams**:\n" +
                        "- **ID**: 1, **Name**: Red Bull Racing Honda RBPT, **Country**: Austria\n" +
                        "- **ID**: 2, **Name**: McLaren Mercedes, **Country**: United Kingdom\n" +
                        "- **ID**: 3, **Name**: Ferrari, **Country**: Italy\n" +
                        "- **ID**: 4, **Name**: Mercedes, **Country**: Germany\n" +
                        "- **ID**: 5, **Name**: Aston Martin Aramco Mercedes, **Country**: United Kingdom\n" +
                        "- **ID**: 6, **Name**: Haas Ferrari, **Country**: USA\n" +
                        "- **ID**: 7, **Name**: RB Honda RBPT, **Country**: Italy\n" +
                        "- **ID**: 8, **Name**: Alpine Renault, **Country**: France\n" +
                        "- **ID**: 9, **Name**: Williams Mercedes, **Country**: United Kingdom\n" +
                        "- **ID**: 10, **Name**: Kick Sauber Ferrari, **Country**: Switzerland\n\n" +
                        "**Races**:\n" +
                        "- **ID**: 17, **Season**: 2024, **Round**: 17, **Name**: Azerbaijan GP, **Circuit ID**: 17, **Date**: 2024-09-15, **Time**: 15:00:00\n" +
                        "- **ID**: 18, **Season**: 2024, **Round**: 18, **Name**: Singapore GP, **Circuit ID**: 18, **Date**: 2024-09-22, **Time**: 20:00:00\n" +
                        "- **ID**: 19, **Season**: 2024, **Round**: 19, **Name**: United States GP, **Circuit ID**: 19, **Date**: 2024-10-20, **Time**: 14:00:00\n" +
                        "- **ID**: 20, **Season**: 2024, **Round**: 20, **Name**: Mexican GP, **Circuit ID**: 20, **Date**: 2024-10-27, **Time**: 14:00:00\n" +
                        "- **ID**: 21, **Season**: 2024, **Round**: 21, **Name**: Brazilian GP, **Circuit ID**: 21, **Date**: 2024-11-03, **Time**: 14:00:00\n" +
                        "- **ID**: 22, **Season**: 2024, **Round**: 22, **Name**: Las Vegas GP, **Circuit ID**: 22, **Date**: 2024-11-23, **Time**: 22:00:00\n" +
                        "- **ID**: 23, **Season**: 2024, **Round**: 23, **Name**: Qatar GP, **Circuit ID**: 23, **Date**: 2024-12-01, **Time**: 19:00:00\n" +
                        "- **ID**: 24, **Season**: 2024, **Round**: 24, **Name**: Abu Dhabi GP, **Circuit ID**: 24, **Date**: 2024-12-08, **Time**: 17:00:00\n\n"
        )
)
public class OpenApiConfig {
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
