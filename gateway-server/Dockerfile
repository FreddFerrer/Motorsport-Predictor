FROM openjdk:17-jdk-slim
ARG JAR_FILE=target/gateway-server-1.0.0.jar
COPY ${JAR_FILE} gateway-server.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "gateway-server.jar"]