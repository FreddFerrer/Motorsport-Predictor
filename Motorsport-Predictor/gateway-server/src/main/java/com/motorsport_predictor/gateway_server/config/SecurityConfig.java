package com.motorsport_predictor.gateway_server.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
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
                    auth.pathMatchers("/api/groups/list").permitAll();
                    auth.pathMatchers("/api/groups/{groupId}/getMembers").permitAll();
                    auth.pathMatchers("/api/groups/getGroupsByUserId/{userId}").permitAll();
                    auth.pathMatchers("/api/groups/popularGroups").permitAll();
                    auth.pathMatchers("/api/groups/search/{searchTerm}").permitAll();
                    auth.pathMatchers("/api/groups/{groupId}/getMembers").permitAll();

                    //f1-service
                    auth.pathMatchers("/api/f1/races").permitAll();
                    auth.pathMatchers("/api/f1/nextRace").permitAll();

                    //predictions-service


                    auth.anyExchange().authenticated();
                })
                .oauth2Login(Customizer.withDefaults());

        return http.build();
    }
}
