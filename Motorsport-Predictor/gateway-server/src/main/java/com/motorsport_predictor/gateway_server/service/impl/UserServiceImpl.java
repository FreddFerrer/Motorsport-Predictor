package com.motorsport_predictor.gateway_server.service.impl;

import com.motorsport_predictor.gateway_server.dto.request.LoginRequestDTO;
import com.motorsport_predictor.gateway_server.service.IUserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements IUserService {


    @Override
    public Map<String, Object> login(@Valid LoginRequestDTO loginRequestDTO) {
        if (loginRequestDTO.getPassword() == null || loginRequestDTO.getPassword().isEmpty()) {
            throw new IllegalArgumentException("Password field is required and cannot be empty.");
        }

        String url = "http://localhost:9090/realms/microservices-motorsport-predictor-realm/protocol/openid-connect/token";

        String body = "client_id=microservices-motorsport-client" +
                "&client_secret=cKqUA6aHPFAU4kaZjXe7FY1mw1VwVxxh" +
                "&grant_type=password" +
                "&username=" + loginRequestDTO.getUsername() +
                "&password=" + loginRequestDTO.getPassword() +
                "&scope=openid";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<String> request = new HttpEntity<>(body, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.POST, request, Map.class);

        // Verificar el estado de la respuesta
        if (response.getStatusCode() == HttpStatus.OK) {
            Map<String, Object> responseBody = response.getBody();

            return responseBody;
        } else {
            throw new RuntimeException("Error en la autenticación: " + response.getStatusCode());
        }
    }
}