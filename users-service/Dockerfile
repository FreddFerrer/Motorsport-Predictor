FROM openjdk:17-jdk-slim
ARG JAR_FILE=target/users-service-1.0.0.jar
COPY ${JAR_FILE} users-service.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "users-service.jar"]