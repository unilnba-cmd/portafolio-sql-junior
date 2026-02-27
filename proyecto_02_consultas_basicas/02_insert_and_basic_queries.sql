-- ============================================
-- Project 02: Insert and Basic Queries
-- Author: Nelson Antonio Blandón
-- Description: Practice data insertion and basic SQL queries
-- ============================================

USE escuela_db;

-- Insert sample data into estudiantes table
INSERT INTO estudiantes (id, nombre, edad, correo)
VALUES
(1, 'Carlos Martinez', 20, 'carlos@email.com'),
(2, 'Ana Lopez', 22, 'ana@email.com'),
(3, 'Luis Gomez', 19, 'luis@email.com'),
(4, 'Maria Torres', 21, 'maria@email.com'),
(5, 'Sofia Ramirez', 23, 'sofia@email.com');

-- Select all students
SELECT * FROM estudiantes;

-- Select students older than 20
SELECT nombre, edad
FROM estudiantes
WHERE edad > 20;

-- Order students by age descending
SELECT nombre, edad
FROM estudiantes
ORDER BY edad DESC;

-- Count total students
SELECT COUNT(*) AS total_students
FROM estudiantes;

-- Calculate average age
SELECT AVG(edad) AS average_age
FROM estudiantes;