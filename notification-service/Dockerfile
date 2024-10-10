FROM openjdk:17-jdk-slim
ARG JAR_FILE=target/notification-service-1.0.0.jar
COPY ${JAR_FILE} notification-service.jar
EXPOSE 8084
ENTRYPOINT ["java", "-jar", "notification-service.jar"]