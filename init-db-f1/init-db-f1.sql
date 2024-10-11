USE db_motorsport_predictor_f1;

GRANT ALL PRIVILEGES ON db_motorsport_predictor_f1.* TO 'freddy'@'%';
FLUSH PRIVILEGES;

-- Creación de la tabla `circuit`
CREATE TABLE IF NOT EXISTS circuit (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    circuit_short_name VARCHAR(255) NOT NULL,
    circuit_name VARCHAR(255) NOT NULL,
    lat DECIMAL(38,2),
    lon DECIMAL(38,2),
    locality VARCHAR(255),
    country VARCHAR(255)
);

-- Creación de la tabla `teams`
CREATE TABLE IF NOT EXISTS teams (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255)
);

-- Creación de la tabla `drivers`
CREATE TABLE IF NOT EXISTS drivers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    shortname VARCHAR(10) NOT NULL,
    nationality VARCHAR(255),
    team_id BIGINT,
    FOREIGN KEY (team_id) REFERENCES teams(id)
);

-- Creación de la tabla `race`
CREATE TABLE IF NOT EXISTS race (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    season VARCHAR(255),
    round INT,
    race_name VARCHAR(255) NOT NULL,
    circuit_id BIGINT,
    `date` DATE,
    `time` TIME,
    FOREIGN KEY (circuit_id) REFERENCES circuit(id)
);

ALTER TABLE db_motorsport_predictor_f1.race MODIFY COLUMN time TIME;

-- Insertar valores en Circuit
INSERT INTO circuit (circuit_short_name, circuit_name, lat, lon, locality, country) VALUES
('bahrain', 'Bahrain International Circuit', '26.03', '50.51', 'Sakhir', 'Bahrain'),
('jeddah', 'Jeddah Corniche Circuit', '21.63', '39.10', 'Jeddah', 'Saudi Arabia'),
('albert_park', 'Albert Park Grand Prix Circuit', '-37.85', '144.97', 'Melbourne', 'Australia'),
('suzuka', 'Suzuka Circuit', '34.84', '136.54', 'Suzuka', 'Japan'),
('shanghai', 'Shanghai International Circuit', '31.34', '121.22', 'Shanghai', 'China'),
('miami', 'Miami International Autodrome', '25.96', '-80.24', 'Miami', 'USA'),
('imola', 'Autodromo Enzo e Dino Ferrari', '44.34', '11.72', 'Imola', 'Italy'),
('monaco', 'Circuit de Monaco', '43.73', '7.42', 'Monte-Carlo', 'Monaco'),
('villeneuve', 'Circuit Gilles Villeneuve', '45.50', '-73.52', 'Montreal', 'Canada'),
('catalunya', 'Circuit de Barcelona-Catalunya', '41.57', '2.26', 'Montmeló', 'Spain'),
('red_bull_ring', 'Red Bull Ring', '47.22', '14.76', 'Spielberg', 'Austria'),
('silverstone', 'Silverstone Circuit', '52.08', '-1.02', 'Silverstone', 'UK'),
('hungaroring', 'Hungaroring', '47.58', '19.25', 'Budapest', 'Hungary'),
('spa', 'Circuit de Spa-Francorchamps', '50.44', '5.97', 'Spa', 'Belgium'),
('zandvoort', 'Circuit Park Zandvoort', '52.39', '4.54', 'Zandvoort', 'Netherlands'),
('monza', 'Autodromo Nazionale di Monza', '45.62', '9.28', 'Monza', 'Italy'),
('baku', 'Baku City Circuit', '40.37', '49.85', 'Baku', 'Azerbaijan'),
('marina_bay', 'Marina Bay Street Circuit', '1.29', '103.86', 'Marina Bay', 'Singapore'),
('americas', 'Circuit of the Americas', '30.13', '-97.64', 'Austin', 'USA'),
('rodriguez', 'Autódromo Hermanos Rodríguez', '19.40', '-99.09', 'Mexico City', 'Mexico'),
('interlagos', 'Autódromo José Carlos Pace', '-23.70', '-46.70', 'São Paulo', 'Brazil'),
('vegas', 'Las Vegas Strip Street Circuit', '36.11', '-115.17', 'Las Vegas', 'United States'),
('losail', 'Losail International Circuit', '25.49', '51.45', 'Al Daayen', 'Qatar'),
('yas_marina', 'Yas Marina Circuit', '24.47', '54.60', 'Abu Dhabi', 'UAE');

-- insertar valores en teams
INSERT INTO teams (name, country) VALUES
('Red Bull Racing Honda RBPT', 'Austria'),
('McLaren Mercedes', 'British'),
('Ferrari', 'Italy'),
('Mercedes', 'Germany'),
('Aston Martin Aramco Mercedes', 'British'),
('Haas Ferrari', 'USA'),
('RB Honda RBPT', 'Italy'),
('Alpine Renault', 'France'),
('Williams Mercedes', 'British'),
('Kick Sauber Ferrari', 'Switzerland');


-- insertar valores en drivers
INSERT INTO drivers (name, shortname, nationality, team_id) VALUES
('Max Verstappen', 'VER', 'NED', 1),
('Lando Norris', 'NOR', 'GBR', 2),
('Charles Leclerc', 'LEC', 'MON', 3),
('Oscar Piastri', 'PIA', 'AUS', 2),
('Carlos Sainz', 'SAI', 'ESP', 3),
('Lewis Hamilton', 'HAM','GBR', 4),
('Sergio Perez', 'PER', 'MEX', 1),
('George Russell', 'RUS', 'GBR', 4),
('Fernando Alonso', 'ALO', 'ESP', 5),
('Lance Stroll', 'STR', 'CAN', 5),
('Nico Hulkenberg', 'HUL', 'GER', 6),
('Yuki Tsunoda', 'TSU', 'JPN', 7),
('Liam Lawson', 'LAW', 'AUS', 7),
('Oliver Bearman', 'BEA', 'GBR', 2),
('Pierre Gasly', 'GAS', 'FRA', 8),
('Kevin Magnussen', 'MAG', 'DEN', 6),
('Esteban Ocon', 'OCO', 'FRA', 8),
('Alexander Albon', 'ALB', 'THA', 9),
('Zhou Guanyu', 'ZHO', 'CHN', 10),
('Franco Colapinto', 'COL', 'ARG', 9),
('Valtteri Bottas', 'BOT', 'FIN', 10);

-- insertar valores en race
INSERT INTO race (season, round, race_name, circuit_id, date, time) VALUES
('2024', 1, 'Bahrain GP', 1, '2024-03-02', '18:00:00'),
('2024', 2, 'Saudi Arabian GP', 2, '2024-03-09', '20:00:00'),
('2024', 3, 'Australian GP', 3, '2024-03-24', '15:00:00'),
('2024', 4, 'Japanese GP', 4, '2024-04-07', '14:00:00'),
('2024', 5, 'Chinese GP', 5, '2024-04-21', '15:00:00'),
('2024', 6, 'Miami GP', 6, '2024-05-05', '16:00:00'),
('2024', 7, 'Emilia Romagna GP', 7, '2024-05-19', '15:00:00'),
('2024', 8, 'Monaco GP', 8, '2024-05-26', '15:00:00'),
('2024', 9, 'Canadian GP', 9, '2024-06-09', '14:00:00'),
('2024', 10, 'Spanish GP', 10, '2024-06-23', '15:00:00'),
('2024', 11, 'Austrian GP', 11, '2024-06-30', '15:00:00'),
('2024', 12, 'British GP', 12, '2024-07-07', '15:00:00'),
('2024', 13, 'Hungarian GP', 13, '2024-07-21', '15:00:00'),
('2024', 14, 'Belgian GP', 14, '2024-07-28', '15:00:00'),
('2024', 15, 'Dutch GP', 15, '2024-08-25', '15:00:00'),
('2024', 16, 'Italian GP', 16, '2024-09-01', '15:00:00'),
('2024', 17, 'Azerbaijan GP', 17, '2024-09-15', '15:00:00'),
('2024', 18, 'Singapore GP', 18, '2024-09-22', '20:00:00'),
('2024', 19, 'United States GP', 19, '2024-10-20', '14:00:00'),
('2024', 20, 'Mexican GP', 20, '2024-10-27', '14:00:00'),
('2024', 21, 'Brazilian GP', 21, '2024-11-03', '14:00:00'),
('2024', 22, 'Las Vegas GP', 22, '2024-11-23', '22:00:00'),
('2024', 23, 'Qatar GP', 23, '2024-12-01', '19:00:00'),
('2024', 24, 'Abu Dhabi GP', 24, '2024-12-08', '17:00:00');