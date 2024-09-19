FROM openjdk:17-jdk-slim
ARG JAR_FILE=target/gateway-server-1.0.0.jar
COPY ${JAR_FILE} gateway-server.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "echo 'Esperando 10 segundos...'; sleep 10; java -jar gateway-server.jar", "--spring.profiles.active=docker"]