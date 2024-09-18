FROM openjdk:17-jdk-slim
ARG JAR_FILE=target/eureka-server-1.0.0.jar
COPY ${JAR_FILE} eureka-server.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar", "eureka-server.jar"]