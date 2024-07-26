
Proyecto en desarrollo

# 🚦 Motorsport-Predictor 🏎️

## Descripción ✏️

Esta aplicación web permite a los usuarios registrados realizar predicciones sobre los resultados de las carreras de Fórmula 1 y competir con otros usuarios para obtener la mayor cantidad de puntos. El proyecto está en desarrollo continuo y se basa en una arquitectura de microservicios para escalabilidad y modularidad.

### Arquitectura 🧱

- Microservicios:
    - Eureka Server: Registro y descubrimiento de servicios.
    - Gateway Server: Punto de entrada único para todas las solicitudes, realiza enrutamiento y filtrado de las mismas.
    - Users Service: Gestiona toda la lógica relacionada con los usuarios (registro, actualicación, eliminación).
    - Predictions Service: Gestiona la creación y almacenamiento de las predicciones.

- Autenticación y Autorización: Keycloak se utiliza para gestionar la autenticación y autorización de los usuarios.

- Base de Datos: MySQL se utiliza para almacenar los datos de los usuarios, predicciones y resultados de las carreras.


### Tecnologías 🤖

- Frontend: Angular...proximamente 😅
- Backend: Spring Boot, Spring Cloud
- Base de Datos: MySQL
- Orquestación: Docker Compose
- Autenticación: Keycloak

### Ejecutar localmente 👨‍💻

1) Clonar el repositorio
2) Construir la imagen Docker (docker-compose build)
3) Iniciar los contenedores

### Próximas caracteristicas ⌛

- Notificaciones por email
- Funcionalidad de chat grupal
- Integración con redes sociales

### CONTRIBUCIONES 👍

Este proyecto esta abierto a contribuciones, si deseas colaborar solo hace un fork del repositorio. 