-- Vamos a repasar todo

-- Crear esquema

CREATE SCHEMA bbdd_videojuego;

-- Crear tablas



CREATE TABLE videojuegos (
		id INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL UNIQUE,
        genero VARCHAR(50) DEFAULT 'Sin Datos',
        categoria ENUM('Familiar', 'Adulto'),
        tienda INT NOT NULL,
        precio FLOAT NOT NULL
        CHECK (precio > 0),
        lanzamiento DATE,
        FOREIGN KEY(tienda) REFERENCES tiendas(id_tienda)
        ON DELETE CASCADE
        ON UPDATE CASCADE
	);

USE bbdd_videojuego;

-- Modificar tablas y columnas

DROP TABLE IF EXISTS videojuego;

ALTER TABLE videojuegos
ADD COLUMN puntuacion FLOAT;

ALTER TABLE videojuegos
MODIFY COLUMN puntuacion FLOAT NOT NULL;

ALTER TABLE videojuegos
RENAME COLUMN puntuacion TO puntos;

ALTER TABLE videojuegos
DROP COLUMN puntos;


-- Insertar datos

USE bbdd_videojuegos;

INSERT INTO videojuegos (nombre, genero, categoria, tienda, precio, lanzamiento)
VALUES ('Super Fun Adventure', 'Aventura', 'Familiar', 1, 49.99, '2023-11-10'),
    ('Dark Warrior', 'Acción', 'Adulto', 2, 59.99, '2024-01-15'),
    ('Puzzle Mania', 'Puzzle', 'Familiar', 1, 19.99, '2022-08-05'),
    ('Zombie Attack', 'Terror', 'Adulto', 3, 34.99, '2023-09-20'),
    ('Racing Pro 2025', 'Carreras', 'Familiar', 4, 29.99, '2025-02-28'),
    ('Galactic Battles', 'Ciencia Ficción', 'Adulto', 2, 69.99, '2023-12-01'),
    ('Farm Life', 'Simulación', 'Familiar', 5, 24.99, '2023-03-12'),
    ('Fantasy Quest', 'Rol', 'Familiar', 3, 39.99, '2023-05-18'),
    ('Crime City', 'Acción', 'Adulto', 4, 44.99, '2024-07-07'),
    ('Space Racer', 'Carreras', 'Familiar', 1, 49.99, '2024-10-10'),
    ('Stardew Valley', 'Simulación', 'Familiar', 5, 44.50, '2010-10-10');

-- Modificar o eliminar datos

UPDATE videojuegos
SET genero = 'Acción'
WHERE nombre = 'Super Fun Adventure';

DELETE FROM videojuegos
WHERE nombre = 'Stardew Valley';

-- Hacer consultar

SELECT *
FROM videojuegos;

SELECT nombre, genero
FROM videjuegos;

SELECT *
FROM videojuegos
WHERE precio > 30;

SELECT *
FROM videojuegos
WHERE categoria = 'Familiar' AND precio > 20;

SELECT *
FROM videojuegos
WHERE tienda = 1 OR precio < 30;

SELECT nombre
FROM videojuegos
WHERE tienda IS NOT NULL;

SELECT nombre AS nombre_videojuego
FROM videojuegos;

SELECT *
FROM videojuegos
ORDER BY precio DESC;

SELECT DISTINCT genero
FROM videojuegos;

SELECT *
FROM videojuegos
LIMIT 3;

SELECT *
FROM videojuegos
WHERE precio BETWEEN 20 AND 40;

SELECT *
FROM videojuegos
WHERE tienda IN (1,2,3);




