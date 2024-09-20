USE db_motorsport_predictor_users;

GRANT ALL PRIVILEGES ON db_motorsport_predictor_users.* TO 'freddy'@'%';
FLUSH PRIVILEGES;

CREATE TABLE IF NOT EXISTS db_motorsport_predictor_users.groups (
    id bigint NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    description varchar(255) NULL,
    is_public tinyint(1) DEFAULT 0,
    created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    creator_id varchar(255) NOT NULL,
    is_official tinyint(1) DEFAULT 0,
    discipline varchar(50) NOT NULL,
    member_count int NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS group_members (
    id bigint NOT NULL AUTO_INCREMENT,
    group_id bigint NOT NULL,
    user_id varchar(255) NOT NULL,
    joined_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY ux_group_members_group_id_user_id (group_id, user_id),
    FOREIGN KEY (group_id) REFERENCES db_motorsport_predictor_users.groups (id) ON DELETE CASCADE
);

-- Cambiar el delimitador temporalmente para manejar el bloque del trigger
DELIMITER $$

DROP TRIGGER IF EXISTS update_group_member_count_after_insert$$

CREATE TRIGGER update_group_member_count_after_insert
AFTER INSERT ON group_members
FOR EACH ROW
BEGIN
  UPDATE `groups`
  SET member_count = member_count + 1
  WHERE id = NEW.group_id;
END$$

DROP TRIGGER IF EXISTS update_group_member_count_after_delete$$

CREATE TRIGGER update_group_member_count_after_delete
AFTER DELETE ON group_members
FOR EACH ROW
BEGIN
  UPDATE `groups`
  SET member_count = member_count - 1
  WHERE id = OLD.group_id;
END$$

-- Restaurar el delimitador estándar
DELIMITER ;

-- Insertar datos en la tabla groups
INSERT INTO db_motorsport_predictor_users.groups (name, description, creator_id, is_public, is_official, discipline, member_count)
VALUES
('Formula 1 NO oficial privado', 'Grupo NO oficial y privado de F1 para predecir resultados', '1118d324-b46c-48ef-ac01-01da1404ae84', 0, 0, 'Formula 1', 0),
('IndyCar oficial', 'Grupo oficial de IndyCar', '1118d324-b46c-48ef-ac01-01da1404ae84', 1, 1, 'IndyCar', 0);

-- Insertar datos en la tabla group_members
INSERT INTO group_members (group_id, user_id)
VALUES
(1, '1118d324-b46c-48ef-ac01-01da1404ae84'),
(2, '1118d324-b46c-48ef-ac01-01da1404ae84');