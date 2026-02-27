-- ============================================
-- Project 03: Relationships and JOIN Queries
-- Author: Nelson Antonio Blandón
-- Description: Create relational tables and perform JOIN operations
-- ============================================

USE escuela_db;

-- Create table cursos
CREATE TABLE cursos (
    id INT PRIMARY KEY,
    nombre_curso VARCHAR(100) NOT NULL,
    creditos INT NOT NULL
);

-- Add foreign key to estudiantes
ALTER TABLE estudiantes
ADD curso_id INT;

ALTER TABLE estudiantes
ADD CONSTRAINT fk_curso
FOREIGN KEY (curso_id) REFERENCES cursos(id);

-- Insert data into cursos
INSERT INTO cursos (id, nombre_curso, creditos)
VALUES
(1, 'Database Fundamentals', 4),
(2, 'Data Analysis', 3),
(3, 'Programming Basics', 5);

-- Update estudiantes with course assignments
UPDATE estudiantes SET curso_id = 1 WHERE id IN (1, 2);
UPDATE estudiantes SET curso_id = 2 WHERE id IN (3, 4);
UPDATE estudiantes SET curso_id = 3 WHERE id = 5;

-- INNER JOIN: Students with their courses
SELECT e.nombre, e.edad, c.nombre_curso
FROM estudiantes e
INNER JOIN cursos c ON e.curso_id = c.id;

-- Count students per course
SELECT c.nombre_curso, COUNT(e.id) AS total_students
FROM cursos c
LEFT JOIN estudiantes e ON c.id = e.curso_id
GROUP BY c.nombre_curso;