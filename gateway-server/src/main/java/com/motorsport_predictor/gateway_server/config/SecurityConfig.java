package com.motorsport_predictor.gateway_server.config;


import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.ReactiveJwtAuthenticationConverter;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;
import reactor.core.publisher.Mono;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebFluxSecurity
public class SecurityConfig {

    @Bean
    public SecurityWebFilterChain securityWebFilterChain(ServerHttpSecurity http) {
        http
                .csrf(ServerHttpSecurity.CsrfSpec::disable)
                .authorizeExchange(exchange -> exchange
                        // Actuator
                        .pathMatchers("/actuator/**").permitAll()

                        // Login
                        .pathMatchers("/api/auth/login").permitAll()
                        .pathMatchers("/api/auth/create").permitAll()

                        // Users-service
                        .pathMatchers("/api/groups/").permitAll()
                        .pathMatchers("/api/groups/populars").permitAll()
                        .pathMatchers("/api/groups/search/{searchTerm}").permitAll()
                        .pathMatchers("/api/groups/{groupId}/members").permitAll()
                        .pathMatchers("/actuator/users-service/**").permitAll()

                        // F1-service
                        .pathMatchers("/api/f1/races").permitAll()
                        .pathMatchers("/api/f1/races/nextRace").permitAll()
                        .pathMatchers("/api/f1/races/{raceId}").permitAll()
                        .pathMatchers("/actuator/f1-service/**").permitAll()

                        // Swagger
                        .pathMatchers("/f1-service/v3/api-docs/**").permitAll()
                        .pathMatchers("/users-service/v3/api-docs/**").permitAll()
                        .pathMatchers("/predictions-service/v3/api-docs/**").permitAll()
                        .pathMatchers("/v3/api-docs/**", "/swagger-ui/**", "/swagger-ui.html").permitAll()
                        .pathMatchers("/webjars/swagger-ui/**").permitAll()

                        // Cualquier otra solicitud necesita autenticación
                        .anyExchange().authenticated()
                )
                .oauth2Login(withDefaults())  // Configura login con OAuth2
                .oauth2ResourceServer(oauth2 -> oauth2.jwt(jwt ->
                        jwt.jwtAuthenticationConverter(jwtAuthConverter())));

        return http.build();
    }

    private Converter<Jwt, Mono<AbstractAuthenticationToken>> jwtAuthConverter() {
        ReactiveJwtAuthenticationConverter converter = new ReactiveJwtAuthenticationConverter();
        converter.setJwtGrantedAuthoritiesConverter(new KeycloakRealmRoleConverter());

        return converter;
    }

    @Bean
    public RouteLocator routeLocator(RouteLocatorBuilder builder) {
        return builder.routes()
                // F1-service
                .route("f1-service", r -> r.path("/api/f1/**")
                        .uri("http://f1-service:8083"))
                // Users-service
                .route("users-service", r -> r.path("/api/users/**", "/api/groups/**")
                        .uri("http://users-service:8081"))
                // Predictions-service
                .route("predictions-service", r -> r.path("/api/predictions/**")
                        .uri("http://predictions-service:8082"))
                // Swagger Docs for services
                .route(r -> r.path("/f1-service/v3/api-docs").and().method(HttpMethod.GET)
                        .uri("http://f1-service:8083"))
                .route(r -> r.path("/users-service/v3/api-docs").and().method(HttpMethod.GET)
                        .uri("http://users-service:8081"))
                .route(r -> r.path("/predictions-service/v3/api-docs").and().method(HttpMethod.GET)
                        .uri("http://predictions-service:8082"))
                // Catch-all for POST requests to localhost
                .route(r -> r.path("/**").and().method(HttpMethod.POST)
                        .uri("https://localhost:8080"))
                .build();
    }

    @Bean
    public CorsWebFilter corsWebFilter() {
        CorsConfiguration corsConfig = new CorsConfiguration();
        corsConfig.addAllowedOrigin("http://localhost:8080");
        corsConfig.addAllowedOrigin("http://localhost:9090");
        corsConfig.addAllowedOrigin("http://localhost");
        corsConfig.addAllowedHeader("*");
        corsConfig.addAllowedMethod("*");
        corsConfig.setAllowCredentials(true);
        corsConfig.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", corsConfig);

        return new CorsWebFilter(source);
    }
}