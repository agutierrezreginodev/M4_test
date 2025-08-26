-- Database creation
CREATE DATABASE IF NOT EXISTS agrovida;
USE agrovida;

-- Table: regions
CREATE TABLE regions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(50) NOT NULL
);

-- Table: crops
CREATE TABLE crops (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    variety VARCHAR(50) NOT NULL
);

-- Table: fertilizers
CREATE TABLE fertilizers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    is_organic VARCHAR(50) NOT NULL
);

-- Tabla: irrigation_systems
CREATE TABLE irrigation_systems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Table: technicians
CREATE TABLE technicians (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Table: sensors
CREATE TABLE sensors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    value DECIMAL(4,2) NOT NULL,
    maintenance_date DATE,
    id_technician INT,
    FOREIGN KEY (id_technician) REFERENCES technicians(id) ON DELETE SET NULL
);

-- Table: soils 
CREATE TABLE soils (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    id_irrigation_system INT,
    id_fertilizer INT,
    FOREIGN KEY (id_irrigation_system) REFERENCES irrigation_systems(id) ON DELETE SET NULL,
    FOREIGN KEY (id_fertilizer) REFERENCES fertilizers(id) ON DELETE SET NULL
);

-- Table: farms
CREATE TABLE farms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    id_region INT,
    id_crop INT,
    id_soil INT,
    id_sensor INT,
    FOREIGN KEY (id_region) REFERENCES regions(id) ON DELETE SET NULL,
    FOREIGN KEY (id_crop) REFERENCES crops(id) ON DELETE SET NULL,
    FOREIGN KEY (id_soil) REFERENCES soils(id) ON DELETE SET NULL,
    FOREIGN KEY (id_sensor) REFERENCES sensors(id) ON DELETE SET NULL
);

-- Table: production
CREATE TABLE production (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_time DATETIME NOT NULL,
    id_farm INT,
    tons INT NOT NULL,
    FOREIGN KEY (id_farm) REFERENCES farms(id) ON DELETE CASCADE
);

-- Indexes
CREATE INDEX idx_production_date ON production(date_time);
CREATE INDEX idx_production_farm ON production(id_farm);
CREATE INDEX idx_sensors_technician ON sensors(id_technician);
CREATE INDEX idx_soils_irrigation ON soils(id_irrigation_system);
CREATE INDEX idx_soils_fertilizer ON soils(id_fertilizer);
CREATE INDEX idx_farms_region ON farms(id_region);
CREATE INDEX idx_farms_crop ON farms(id_crop);
CREATE INDEX idx_farms_soil ON farms(id_soil);
CREATE INDEX idx_farms_sensor ON farms(id_sensor);