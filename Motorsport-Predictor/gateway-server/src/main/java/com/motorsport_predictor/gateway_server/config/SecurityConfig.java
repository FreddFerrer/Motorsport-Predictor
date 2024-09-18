package com.motorsport_predictor.gateway_server.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.core.convert.converter.Converter;
import org.springframework.http.HttpMethod;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.ReactiveJwtAuthenticationConverter;
import org.springframework.security.web.server.SecurityWebFilterChain;
import reactor.core.publisher.Mono;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityWebFilterChain securityWebFilterChain(ServerHttpSecurity http) {
        http
                .csrf(ServerHttpSecurity.CsrfSpec::disable)
                .authorizeExchange(auth -> {
                    //actuator
                    auth.pathMatchers("/actuator/**").permitAll();

                    //login
                    auth.pathMatchers("/api/auth/login").permitAll();

                    //users-service
                    auth.pathMatchers("/api/users/create").permitAll();
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
                .oauth2Login(withDefaults())
                .oauth2ResourceServer(configure ->
                        configure.jwt(jwt -> jwt.jwtAuthenticationConverter(jwtAuthConverter())));

        return http.build();
    }

    private Converter<Jwt, Mono<AbstractAuthenticationToken>> jwtAuthConverter() {
        ReactiveJwtAuthenticationConverter converter = new ReactiveJwtAuthenticationConverter();
        converter.setJwtGrantedAuthoritiesConverter(new KeycloakRealmRoleConverter());

        return converter;
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
