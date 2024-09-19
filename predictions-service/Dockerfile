FROM openjdk:17-jdk-slim
ARG JAR_FILE=target/predictions-service-1.0.0.jar
COPY ${JAR_FILE} predictions-service.jar
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "predictions-service.jar", "--spring.profiles.active=docker"]