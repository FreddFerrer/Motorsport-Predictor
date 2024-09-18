package com.motorsport_predictor.gateway_server.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.context.annotation.Configuration;

@Configuration
@OpenAPIDefinition(
        info = @Info(
                title = "Motorsport Predictor API",
                version = "1.0.0",
                description = "API Gateway v1.0.0. \n\n**Usuarios de Prueba**:\n\n" +
                        "- **usuario_prueba_1** / Password@UserPrueba\n" +
                        "- **usuario_prueba_2** / Password@UserPrueba"
        )
)public class OpenApiConfig {
}
