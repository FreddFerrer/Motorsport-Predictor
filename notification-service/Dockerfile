FROM openjdk:17-jdk-slim
ARG JAR_FILE=target/notification-service-0.0.1.jar
COPY ${JAR_FILE} notification-service.jar
EXPOSE 0
ENTRYPOINT ["java", "-jar", "notification-service.jar"]