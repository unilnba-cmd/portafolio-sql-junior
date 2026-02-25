-- ============================================
-- Proyecto: Academia SQL
-- Autor: Nelson Blandon
-- Descripción: Creación de base de datos y tablas principales
-- ============================================

CREATE DATABASE IF NOT EXISTS academia_portafolio;

USE academia_portafolio;

CREATE TABLE estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    edad INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);