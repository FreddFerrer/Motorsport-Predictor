use db_motorsport_predictor_predictions;

CREATE TABLE IF NOT EXISTS `f1_predictions` (
    `id` bigint NOT NULL AUTO_INCREMENT,
    `driver_id` bigint NOT NULL,
    `race_id` bigint NOT NULL,
    `group_member_id` bigint NOT NULL,
    `predicted_position` int NOT NULL,
    `actual_position` int DEFAULT NULL,
    `points` int DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
);

DELIMITER $$

DROP TRIGGER IF EXISTS update_points_after_update$$

CREATE TRIGGER update_points_after_update
BEFORE UPDATE ON f1_predictions
FOR EACH ROW
BEGIN
    IF NEW.predicted_position = NEW.actual_position THEN
        SET NEW.points = 5;
    ELSE
        SET NEW.points = 0;
    END IF;
END$$

DELIMITER ;