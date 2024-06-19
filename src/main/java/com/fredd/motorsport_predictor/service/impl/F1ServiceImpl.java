package com.fredd.motorsport_predictor.service.impl;

import com.fredd.motorsport_predictor.rest.f1.drivers.F1DriversDto;
import com.fredd.motorsport_predictor.rest.f1.tracks.F1TracksDto;
import com.fredd.motorsport_predictor.service.IF1Service;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

@Service
public class F1ServiceImpl implements IF1Service {

    private final WebClient webClient;

    public F1ServiceImpl(WebClient.Builder builder) {
        webClient = builder.baseUrl("http://ergast.com/api/f1").build();
    }

    @Override
    public F1DriversDto getDriversByYear(int year) {
        return webClient
                .get()
                .uri("/" + year + "/drivers.json")
                .retrieve()
                .bodyToMono(F1DriversDto.class).block();
    }

    @Override
    public F1TracksDto getCurrentSchedule() {
        return webClient
                .get()
                .uri("/current.json")
                .retrieve()
                .bodyToMono(F1TracksDto.class).block();
    }
}
