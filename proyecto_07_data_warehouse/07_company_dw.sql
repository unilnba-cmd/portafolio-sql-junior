USE sistema_estudiantes;
CREATE TABLE estudiantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    nota1 DOUBLE,
    nota2 DOUBLE,
    nota3 DOUBLE,
    promedio DOUBLE,
    estado VARCHAR(20)
);
SHOW TABLES;
INSERT INTO estudiantes (nombre, nota1, nota2, nota3, promedio, estado)
VALUES ('Angel', 100, 99, 98, 99, 'APROBADO');
SELECT * FROM estudiantes;
CREATE DATABASE sistemamyql;

