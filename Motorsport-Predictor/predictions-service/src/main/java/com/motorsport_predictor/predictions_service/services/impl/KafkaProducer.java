package com.motorsport_predictor.predictions_service.services.impl;

import com.motorsport_predictor.predictions_service.dto.PredictionNotificationDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KafkaProducer {
    private final KafkaTemplate<String, String> kafkaTemplate;
    @Value("${kafka.topic.prediction-notifications}")
    private String topicName;

    public void sendPredictionNotification(String message) {
        kafkaTemplate.send(topicName, message);
    }
}
