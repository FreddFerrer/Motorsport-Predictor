
Proyecto en desarrollo

# 🚦 Motorsport-Predictor 🏎️

## Descripción ✏️

Motorsport Predictor API permite a los usuarios registrados realizar predicciones sobre los resultados de las carreras de Fórmula 1 y competir con otros usuarios para obtener la mayor cantidad de puntos. El proyecto está en desarrollo continuo y se basa en una arquitectura de microservicios para escalabilidad y modularidad.

### Arquitectura 🧱

- Microservicios:
    - **Eureka Server**: Registro y descubrimiento de servicios.
    - **Gateway Server**: Punto de entrada único para todas las solicitudes, realiza enrutamiento y filtrado de las mismas.
    - **Users Service**: Gestiona toda la lógica relacionada con los usuarios (registro, actualicación, eliminación).
    - **F1 Service**: Proporciona información sobre las carreras de Fórmula 1, incluidos resultados, pilotos, y manejo de datos sobre las competiciones.
    - **Predictions Service**: Gestiona la creación y almacenamiento de las predicciones.
    - **Notification Service**: Se encarga de enviar avisos mediante email al ocurrir eventos importantes.



- Autenticación y Autorización: Keycloak se utiliza para gestionar la autenticación y autorización de los usuarios.

- Base de Datos: MySQL se utiliza para almacenar los datos de los usuarios, predicciones y resultados de las carreras.


### Tecnologías 🤖

- Backend: Spring Boot, Spring Cloud
- Base de Datos: MySQL
- Comunicacion entre microservicios: Kafka y OpenFeing
- Tolerancia a fallos: Resilience4j
- Autenticación: Keycloak

### Ejecutar localmente 👨‍💻

1) Clonar el repositorio `git clone https://github.com/FreddFerrer/Motorsport-Predictor.git`
2) Configura el entorno:
   - Navega al directorio del proyecto: `cd Motorsport-Predictor`.
   - Copia el archivo `.env.example` y renómbralo a `.env`.
   - Abre el archivo .env con un editor de texto y reemplaza los valores de MAIL_USERNAME y MAIL_PASSWORD con tus credenciales de Gmail.
3) Construir e iniciar los contenedores:
   - `docker-compose build`
   - `docker-compose up -d`
4) Ingresar a http://localhost:8080/webjars/swagger-ui/4.15.5/index.html?urls.primaryName=Motorsport%20Predictor%20API 

### Próximas caracteristicas ⌛

- Funcionalidad de chat grupal
- Integración con redes sociales

### CONTRIBUCIONES 👍

Este proyecto esta abierto a contribuciones, si deseas colaborar solo hace un fork del repositorio. 
