FROM openjdk:17-jdk-slim
ARG JAR_FILE=target/f1-service-1.0.0.jar
COPY ${JAR_FILE} f1-service.jar
EXPOSE 8083
ENTRYPOINT ["java", "-jar", "f1-service.jar", "--spring.profiles.active=docker"]