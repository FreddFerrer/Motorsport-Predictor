package com.motorsport_predictor.f1_service;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
@OpenAPIDefinition(info = @Info(title = "F1 Service", version = "1.0", description = "Documentation F1 Service v1.0"))
public class F1ServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(F1ServiceApplication.class, args);
	}

}
