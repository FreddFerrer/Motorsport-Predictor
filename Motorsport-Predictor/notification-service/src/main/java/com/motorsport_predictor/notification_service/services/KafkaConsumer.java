package com.motorsport_predictor.notification_service.services;

import com.motorsport_predictor.notification_service.dto.PredictionDTO;
import com.motorsport_predictor.notification_service.dto.PredictionNotificationDTO;
import com.motorsport_predictor.notification_service.utils.JsonUtils;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component
public class KafkaConsumer {
    @KafkaListener(topics = "${kafka.topic.prediction-notifications}", groupId = "${spring.kafka.consumer.group-id}")
    public void consume(String notification) {
        sendEmail(JsonUtils.fromJson(notification, PredictionNotificationDTO.class));
    }

    private void sendEmail(PredictionNotificationDTO notification) {
        String emailContent = generateEmailContent(notification);
        // Aquí implementas la lógica para enviar el correo usando, por ejemplo, JavaMailSender
        System.out.println("Enviando correo a " + notification.getEmail() + " con el contenido: " + emailContent);
    }

    private String generateEmailContent(PredictionNotificationDTO notification) {
        StringBuilder sb = new StringBuilder();
        sb.append("Estas son tus predicciones:\n");
        for (PredictionDTO prediction : notification.getPredictions()) {
            sb.append("Piloto: " + prediction.getDriverId() + " - Posición: " + prediction.getPredictedPosition() + "\n");
        }
        return sb.toString();
    }
}
