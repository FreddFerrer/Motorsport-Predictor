package com.motorsport_predictor.predictions_service;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
@OpenAPIDefinition(info = @Info(title = "Predictions Service", version = "1.0", description = "Documentation Predictions Service v1.0"))
public class PredictionsServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(PredictionsServiceApplication.class, args);
	}

}
