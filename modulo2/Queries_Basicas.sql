/* Hemos visto:
-Crear tablas
-Insertar datos
-Leer datos
-Modificar datos
-Eliminar datos


Hoy vamos a ver:
-SELECT
-WHERE
-ORDER BY
-LIMIT Y OFFSET
-BETWEEN
-IN
-AS
-DISTINCT
-IS NULL/IS NOT NULL

*/

USE sakila;

SELECT *
FROM actor;

SELECT
first_name,
last_name
FROM actor;

/*¿Y si queremos ver solo las 5 primeras líneas?*/
SELECT first_name
FROM actor
LIMIT 5;

/*Quiero buscar actores con el apellido Guiness*/
SELECT *
FROM actor
WHERE last_name = 'GUINESS';

/*Ahora quiero buscando donde el apellido sea Guiness y el nombre Penélope. ¿Cómo lo hago?*/



/*Ahora quiero que me saque actores con apellido williams o smith*/

SELECT 
first_name,
last_name
FROM actor
WHERE last_name = 'WILLIAMS' OR last_name = 'SMITH';


/*Hay otra manera de hacer dos condiciones*/

SELECT 
first_name,
last_name
FROM actor
WHERE last_name IN ('WILLIAMS', 'SMITH');

/*Y si no quiero ninguno de los dos apellidos...*/

SELECT 
first_name,
last_name
FROM actor
WHERE last_name NOT IN ('WILLIAMS', 'SMITH');

/*También podemos trabajar con comparativos*/

SELECT * 
FROM film
WHERE rental_rate >= 2.99;

SELECT * 
FROM film
WHERE release_year != 1994;

/*Y ahora... ¿Cómo ordenamos los resultados?*/ 

SELECT
title,
rental_rate
FROM film
WHERE rental_rate >= 2.99
ORDER BY rental_rate;

SELECT
title
FROM film
ORDER BY length;

/* Usamos
-ASC para ascendente (Si no ponemos nada, nos lo ordena directamente de menor a mayor)
-DESC para descendente */

SELECT
title,
rental_rate
FROM film
ORDER BY rental_rate DESC;

/*¿Y si queremos ordenar por dos columnas?
-Primero me lo ordena por rate y en los que tienen el mismo rate, lo ordena por duración*/

SELECT
title,
rental_rate
FROM film
ORDER BY rental_rate DESC, length DESC
LIMIT 10;

/*IS NULL Y IS NOT NULL*/

SELECT *
FROM film
WHERE title IS NOT NULL;

SELECT *
FROM film
WHERE title IS NULL;


/*LIMIT Y OFFSET*/

SELECT first_name,
last_name
FROM actor
LIMIT 2;

/*Me saca los dos primeros por defecto. Pero si queremos saltarnos algunos, usamos el OFFSET. Sáltate X registros.*/

SELECT first_name,
last_name
FROM actor
LIMIT 2 OFFSET 3;

/*¿Cómo podríamos usar el BETWEEN?*/

SELECT
title,
rental_rate
FROM film
WHERE rental_rate BETWEEN 1.99 AND 4.99
ORDER BY rental_rate;

-- Ya sabemos que podemos buscar dentro de opciones con IN

SELECT 
title,
rating
FROM film
WHERE rating IN ('PG', 'G', 'NC-17');

/*Pero y yo cómo sé cuantos tipos y cuáles diferentes hay de rating? Veamos...*/

SELECT DISTINCT rating
FROM film;

/*El DISTINCT se suele usar con variables categóricas. Es muy práctico para identificar las diferentes categorías que hay de un campo*/

SELECT DISTINCT ciudad
FROM leccion_crear_tablas.adalaber;

SELECT DISTINCT curso
FROM leccion_crear_tablas.adalaber;

-- Si seleccionamos dos columnas con DISTINCT obtendremos las combinaciones únicas de los valores de ambas columnas

SELECT DISTINCT curso, ciudad
FROM leccion_crear_tablas.adalaber;

-- Usamos la palabra clave AS para llamar a una columna por un alias, PERO este cambio no se guarda, solo para mostrarlo en los resultados

SELECT nombre, ciudad AS residencia
FROM leccion_crear_tablas.adalaber;

-- Orden de las operaciones en SQL:
SELECT
FROM
JOIN
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT;


/*Veamos más ejemplos*/

USE tienda;

SELECT *
FROM customers;


/*¿Cómo puedo saber los diferentes países que hay en esta tabla?*/


/*Ahora quiero mostrar los datos de Francia, Bélgica y España*/

SELECT *
FROM customers
WHERE country IN ('France', 'Spain', 'Belgium');

/*Ahora solo quiero que me muestre, con la condición anterior, pero solo el customer name*/


