package com.motorsport_predictor.gateway_server.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.core.convert.converter.Converter;
import org.springframework.http.HttpMethod;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.ReactiveJwtAuthenticationConverter;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;
import org.springframework.web.reactive.config.EnableWebFlux;
import reactor.core.publisher.Mono;
import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebFlux
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
                    auth.pathMatchers("/api/auth/create").permitAll();

                    //users-service
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
                .route(r -> r.path("/f1-service/v3/api-docs").and().method(HttpMethod.GET).uri("http://f1-service:8083"))
                .route(r -> r.path("/users-service/v3/api-docs").and().method(HttpMethod.GET).uri("http://users-service:8081"))
                .route(r -> r.path("/predictions-service/v3/api-docs").and().method(HttpMethod.GET).uri("http://predictions-service:8082"))
                .route(r -> r.path("/**").and().method(HttpMethod.POST).uri("http://localhost:8080"))
                .build();
    }

    @Bean
    public CorsWebFilter corsWebFilter() {
        CorsConfiguration corsConfig = new CorsConfiguration();
        corsConfig.addAllowedOrigin("http://localhost"); // Permite localhost
        corsConfig.addAllowedOrigin("http://localhost:8080"); // Permite localhost
        corsConfig.addAllowedOrigin("http://localhost:9090"); // Permite localhost
        corsConfig.addAllowedHeader("*");
        corsConfig.addAllowedMethod("*");
        corsConfig.setAllowCredentials(true);
        corsConfig.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", corsConfig);

        return new CorsWebFilter(source);
    }
}
