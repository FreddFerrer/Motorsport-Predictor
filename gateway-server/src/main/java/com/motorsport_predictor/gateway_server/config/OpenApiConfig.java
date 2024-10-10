package com.motorsport_predictor.gateway_server.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Info;
import org.springframework.context.annotation.Configuration;

@Configuration
@OpenAPIDefinition(
        info = @Info(
                title = "Motorsport Predictor API",
                version = "1.0.0",
                description = "API Gateway v1.0.0 para **Motorsport Predictor**, una plataforma que permite a los usuarios hacer predicciones sobre los resultados de carreras de Fórmula 1 y otras competiciones de motorsport." +
                        " Los usuarios pueden crear y pertenecer a grupos donde realizarán predicciones sobre la posición de los pilotos antes de cada carrera.\n" +
                        "\n" +
                        "Después de cada carrera, el administrador del proyecto actualiza los resultados en la plataforma. Los usuarios que acierten las posiciones de los pilotos recibirán +5 puntos por cada posición correcta. " +
                        "Estos puntos se reflejarán en un ranking grupal, donde se mostrará a los usuarios con más puntos.\n\n" +
                        "**ACLARACIÓN**:\n\n" +
                        "Después de realizar el login, los usuarios deben obtener el **access_token** y pegarlo en el campo correspondiente de Swagger para acceder a los endpoints protegidos.\n\n" +
                        "**Usuarios de Prueba**:\n\n" +
                        "- **usuario_prueba_1** / Password@123\n" +
                        "- **usuario_prueba_2** / Password@123\n\n" +
                        "**Microservicios del Proyecto**:\n\n" +
                        "- **API Gateway**: Maneja el enrutamiento de las solicitudes a los microservicios correspondientes y expone los endpoints de la API.\n" +
                        "- **Users Service**: Administra la información de los usuarios, incluyendo su registro.\n" +
                        "- **Predictions Service**: Gestiona las predicciones de los usuarios, validando la cantidad de predicciones permitidas y guardando las posiciones predichas de los pilotos para cada carrera.\n" +
                        "- **F1 Service**: Proporciona información sobre las carreras de Fórmula 1, incluidos resultados, pilotos, y manejo de datos sobre las competiciones.\n" +
                        "- **Notification Service**: Se encarga de enviar notificaciones por correo electrónico a los usuarios cuando realizan predicciones o se producen eventos relevantes.\n\n"
        )
)
public class OpenApiConfig {
}
