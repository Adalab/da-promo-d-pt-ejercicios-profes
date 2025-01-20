/* LECCIÓN SUBCONSULTAS

-Subconsulta: consulta dentro de otra consulta
-Se usan cuando necesitamos datos adicionales de otra tabla
-Normalmente, la subconsultas simples da como resultado una única columna

-- =/IN/NOT IN: para seleccionar entre varios valores que devuelve la subconsulta
-- ANY/ALL (comparación): Para comparar, normalmente datos numéricos
-- EXISTS (existencia): Para verificar si algo existe en el resultado de una subconsulta

*/

-- FILTRADO DE RESULTADOS (=/IN/NOT IN)

-- En la BBDD tienda, quiero ver los empleados que son de Boston

USE tienda;

SELECT DISTINCT office_code, city
FROM offices;

SELECT office_code
FROM offices
WHERE city = 'Boston'; -- Desde la tabla offices, puedo filtrar por ciudad

-- Pero ahora quiero consultar la tabla empleados para ver el nombre de los que están en Boston

SELECT * FROM employees;
SELECT * FROM offices; -- Esto se podría unir con un JOIN, pero también podemos solucionarlo con una subconsulta

/* La consulta sería algo así como

SELECT nombre_empleado
FROM employees
WHERE office_code = al código de Boston. ¡Pero esto no lo tengo en la tabla empleados, sino en offices!


 */

SELECT 
first_name,
last_name
FROM employees
WHERE office_code = (SELECT office_code FROM offices WHERE city = 'Boston');


-- Ahora queremos buscar los de USA

SELECT office_code 
FROM offices 
WHERE country = 'USA'; -- Pero ahora el resultado no es uno, son varios. No me vale el =


SELECT DISTINCT 
employee_number,
last_name
FROM employees
WHERE office_code IN (SELECT office_code FROM offices WHERE country = 'USA');


CREATE SCHEMA subconsultas;
CREATE TABLE subconsultas.USA_employees AS 
SELECT DISTINCT 
employee_number,
last_name
FROM employees
WHERE office_code IN (SELECT office_code FROM offices WHERE country = 'USA');

-- Con una subconsulta, muestra los titulos de las peliculas que hayan sido alquiladas más de 50 veces
-- Para saber qué film_id han sido alquiladas más de 50 veces tendría que consultar las tablas inventory y rental
USE sakila;

-- La estructura que quiero

SELECT title AS pelicula
FROM film
WHERE film_id IN () los id de las películas que se hayan alquilado más de 50 veces. Pero, ¿cómo consigo esos id?

SELECT i.film_id 
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY i.film_id
HAVING COUNT(*) > 20; -- usamos * cuando queremos contar las filas del resultado, en este caso, las filas de cada grupo

-- Resultado: 

SELECT title AS pelicula
FROM film
WHERE film_id IN (SELECT i.film_id 
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY i.film_id
HAVING COUNT(*) > 20);


-- COMPARACIÓN ( ANY/ALL)

-- El operador ANY se utiliza cuando deseas verificar si una condición es verdadera 
-- para al menos uno de los valores devueltos por la subquery. 
-- Es equivalente a usar "alguno" o "cualquiera" en lenguaje natural.
-- Se utiliza con =, >, <, >=, <=, !=
-- Se suele utilizar para comparar valores numéricos, por ejemplo, "muestrame los valores que sean mayor a cualquiera de las duraciones de las películas de 2020" >ANY(SELECT)


-- Ejemplo: Encuentra las películas cuya duración sea mayor que la duración de cualquiera de las 
-- películas con una calificación "PG".

USE sakila;

-- Primero habrá que saber la duración de las películas que son PG
SELECT length
FROM film
WHERE rating = 'PG'

-- Ahora quiero que me muestre solo las que duran más que cualquiera de estas
    
SELECT title, length
FROM film
WHERE length > ANY (
    SELECT length
    FROM film
    WHERE rating = 'PG'
);


-- El operador ALL se utiliza cuando deseas verificar si una condición es verdadera para todos los valores
-- devueltos por la subquery. Es equivalente a usar "todos" en lenguaje natural.



-- Ejemplo: Encuentra las películas cuya duración sea mayor que TODAS las películas con una calificación "PG".
-- Primero tendremos que saber la duración de las películas que son PG

SELECT length
FROM film
WHERE rating = 'PG';

-- Ahora solo queremos ver las películas cuya duración sean mayor que TODAS estas duraciones

SELECT title, length
FROM film
WHERE length > ALL (
    SELECT length
    FROM film
    WHERE rating = 'PG'
);


-- EXISTS
-- El operador EXISTS en SQL se utiliza para verificar si una subquery devuelve 
-- al menos una fila. Es útil cuando no necesitas obtener datos específicos de la subquery, 
-- sino simplemente comprobar si el conjunto de resultados existe o no. 
-- Si la subquery devuelve al menos una fila, EXISTS evalúa como TRUE. Si no devuelve filas, se evalúa como FALSE.


-- Ejemplo: Encuentra los nombres de las categorías que tienen al menos una película asociada.
-- Le tengo que pedir los registros donde mi columna category_id también aparezca en film_category

SELECT name
FROM category
WHERE EXISTS (
    SELECT *
    FROM film_category
    WHERE film_category.category_id = category.category_id
);

-- Esto además, sería una subconsulta correlacionada, porque depende de la consulta principal

-- ¿Cuándo usar una subconsulta en vez de JOIN?
-- Cuando solo necesitamos un valor o cuando no necesitamos mostrar datos de varias tablas diferentes


-- Más ejemplos de subconsultas
-- Quiero ver los empleados que cobran más que el empleado con el id 2
--
USE Northwind;

SELECT * FROM employees;
-- En este caso, tengo todos los datos que necesito en la misma tabla. El sueldo lo tengo que buscar aquí, en salary
-- Cuando hago una subconsulta de la misma tabla, le tengo que dar un mote diferente, si es que decido ponerselo

SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > (
    SELECT Salary
    FROM Employees
    WHERE EmployeeID = 2
);

-- Quiero ver a los empleados cuyo salario sea mayor que el de todos los empleados del departamento de Sales

SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM Employees
    WHERE Department = 'Sales'
);

-- Queremos encontrar los empleados que reportan al empleado con id 5

SELECT FirstName, LastName
FROM Employees
WHERE EmployeeID IN (
    SELECT EmployeeID
    FROM Employees
    WHERE ReportsTo = 5
);

-- Ejemplo doble subconsulta
-- Queremos encontras las películas que no están en alquiler actualmente

SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;

SELECT title
FROM film
WHERE film_id NOT IN (
    SELECT film_id
    FROM inventory
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM rental
        WHERE return_date IS NULL
    )
);