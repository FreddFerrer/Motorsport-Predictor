package com.motorsport_predictor.f1_service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
public class F1ServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(F1ServiceApplication.class, args);
	}

}