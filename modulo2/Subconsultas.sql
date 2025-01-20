-- Hoy vamos a ver SUBCONSULTAS Y SUBCONSULTAS RELACIONADAS

-- SUBCONSULTAS: Consultas dentro de otras consultas
-- Se utiliza cuando necesitamos datos adicionales de otra tabla para completar nuestra consulta principal
-- Las subconsultas se suelen usar con palabras clave como IN, NOT IN, ANY, ALL y EXISTS


USE tienda;

SELECT *
FROM employees;

SELECT *
FROM offices;

-- Ahora quiero seleccionar los empleados cuya oficina estén en Boston
-- En employees tenemos el codigo, pero no la ciudad, eso lo tenemos en offices
-- Tenemos que filtrar los datos de una tabla, basandonos en una condicion de otra tabla

-- Esta sería nuestra condición. Pero en la tabla employees, solo aparece el office_code de Boston, que es 2

SELECT
office_code
FROM offices
WHERE city = "Boston";

-- Quiero seleccionar en mi tabla de empleados el nombre y apellido

SELECT
employee_number,
last_name
FROM employees
WHERE office_code = (SELECT
office_code
FROM offices
WHERE city = "Boston");


-- Seleccionamos los empleados que trabajen en las oficinas de USA
-- subquery: seleccionar los office code de USA
-- query principal: selecionar los nombres de los empleados cuyo office_code sea el de los de USA

SELECT
employee_number,
last_name
FROM employees
WHERE office_code IN (
			SELECT office_code
            FROM offices
            WHERE country = 'USA');
            
-- Aquí habría que usar IN en vez de = porque hay más de un office_code relacionado con USA


-- Las subconsulta se usan en cláusulas como SELECT, FROM, WHERE
-- ejemplo en WHERE

-- Actores que han trabajado en mas de 50 peliculas
USE sakila;

SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    HAVING COUNT(film_id) > 50
);
    
-- ejemplo en SELECT
-- Mostramos el numero de veces que ha sido alquilada cada pelicula
SELECT title,
       (SELECT COUNT(*)
        FROM rental
        JOIN inventory ON rental.inventory_id = inventory.inventory_id
        WHERE inventory.film_id = film.film_id) AS rental_count
FROM film;


-- OPERADORES DE COMPARACIÓN MÁS COMPLICADOS Y SE USAN MENOS
-- ANY/ALL

-- ANY:
-- Se usa para verificar si la condición es ver dadera para alguno de los resultados de la query


-- Ej: Encontrar las películas cuya duración sea mayor que la duración de CUALQUIERA de las pelis con calificación 'PG'
-- Seleccionamos películas. COmparamos su duración con las películas 'PG' y mostramos las que tienen duracion mayor

USE sakila;

SELECT * 
FROM film;

SELECT
title,
length
FROM film
WHERE length > ANY (
		SELECT length
        FROM
        film
        WHERE rating = 'PG');
        
        
SELECT length
FROM
film
WHERE rating = 'PG';

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id > ANY (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 100
);

-- ALL se utiliza para verificar si esa condición es verdadera para todos los resultados

-- Mostrar las películas que tengan una duracion más larga que TODAS las de PG

SELECT
title,
length
FROM film
WHERE length > ALL (
		SELECT length
        FROM
        film
        WHERE rating = 'PG');
	
-- Obtenemos los customer_id que sean mayores que todos los customer_id de los clientes
-- que han alquilado más de 50 pelis

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id > ALL (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 50
);
        
-- EXISTS

SELECT *
FROM category;

SELECT
name
FROM category
WHERE EXISTS 
		(SELECT *
        FROM film_category
        WHERE category.category_id = film_category.category_id
        );
        
-- Seleccioname todos los datos de la tabla film category donde category_id coincide con el category_id de la otra tabla