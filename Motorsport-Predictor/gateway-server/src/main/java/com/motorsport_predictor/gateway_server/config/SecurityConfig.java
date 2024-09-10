package com.motorsport_predictor.gateway_server.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.web.server.SecurityWebFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityWebFilterChain securityWebFilterChain(ServerHttpSecurity http) {
        http
                .csrf(ServerHttpSecurity.CsrfSpec::disable)
                .authorizeExchange(auth -> {
                    //actuator
                    auth.pathMatchers("/actuator/**").permitAll();

                    //users-service
                    auth.pathMatchers("/api/users/create").permitAll();
                    auth.pathMatchers("/api/users/login").permitAll();
                    auth.pathMatchers("/api/groups/").permitAll();
                    auth.pathMatchers("/api/groups/populars").permitAll();
                    auth.pathMatchers("/api/groups/search/{searchTerm}").permitAll();
                    auth.pathMatchers("/api/groups/{groupId}/members").permitAll();

                    //f1-service
                    auth.pathMatchers("/api/f1/races").permitAll();
                    auth.pathMatchers("/api/f1/races/nextRace").permitAll();
                    auth.pathMatchers("/api/f1/races/{raceId}").permitAll();

                    //predictions-service

                    //swagger
                    auth.pathMatchers("/f1-service/v3/api-docs/**").permitAll();
                    auth.pathMatchers("/users-service/v3/api-docs/**").permitAll();
                    auth.pathMatchers("/predictions-service/v3/api-docs/**").permitAll();
                    auth.pathMatchers("/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html").permitAll();
                    auth.pathMatchers("/webjars/swagger-ui/**").permitAll();


                    auth.anyExchange().authenticated();
                })
                .oauth2Login(Customizer.withDefaults());

        return http.build();
    }

    @Bean
    public RouteLocator routeLocator(RouteLocatorBuilder builder) {
        return builder
                .routes()
                .route(r -> r.path("/f1-service/v3/api-docs").and().method(HttpMethod.GET).uri("lb://f1-service"))
                .route(r -> r.path("/users-service/v3/api-docs").and().method(HttpMethod.GET).uri("lb://users-service"))
                .route(r -> r.path("/predictions-service/v3/api-docs").and().method(HttpMethod.GET).uri("lb://predictions-service"))
    .build();
    }
}
