package com.motorsport_predictor.notification_service.services;

import com.motorsport_predictor.notification_service.dto.RaceDTO;
import com.motorsport_predictor.notification_service.utils.JsonUtils;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.ClassPathResource;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Component
@RequiredArgsConstructor
public class KafkaConsumer {
    private final JavaMailSender mailSender;

    @KafkaListener(topics = "${kafka.topic.prediction-notifications}", groupId = "${spring.kafka.consumer.group-id}")
    public void consume(String raceInfo) {
        sendEmail(JsonUtils.fromJson(raceInfo, RaceDTO.class));
    }

    private void sendEmail(RaceDTO raceInfo) {
        String emailContent = generateEmailContent(raceInfo);
        sendHtmlEmail(raceInfo.getEmail(), "Nuevas Predicciones Realizadas", emailContent);
    }

    private String generateEmailContent(RaceDTO raceInfo) {
        String htmlContent = loadHtmlTemplate();

        htmlContent = htmlContent.replace("{raceName}", raceInfo.getRaceName());
        htmlContent = htmlContent.replace("{date}", raceInfo.getDate().toString());
        htmlContent = htmlContent.replace("{circuitName}", raceInfo.getCircuit().getCircuitName());
        htmlContent = htmlContent.replace("{country}", raceInfo.getCircuit().getCountry());

        return htmlContent;
    }

    private void sendHtmlEmail(String to, String subject, String htmlContent) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            System.out.println("Correo enviado a " + to);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error al enviar el correo: " + e.getMessage());
        }
    }

    private String loadHtmlTemplate() {
        try {
            Path path = Paths.get(new ClassPathResource("templates/email-content.html").getURI());
            return new String(Files.readAllBytes(path));
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error al cargar la plantilla HTML", e);
        }
    }
}
