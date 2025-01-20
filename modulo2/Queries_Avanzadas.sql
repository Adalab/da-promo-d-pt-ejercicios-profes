/* Hasta ahora hemos...

-Creado tablas
-Insertado datos
-Actualizado
-Eliminado
-Seleccionado
-Filtros con WHERE


Ahora veremos:
-Funciones agregadas (funciones que nos permiten hacer cálculos en nuestros datos): SUM, AVG, COUNT, MAX, MIN
-Funciones para organizar y filtrar nuestros datos: GROUP BY, HAVING, CASE


--MIN/MAX: Para sacar el valor mínimo o máximo de una columna

SELECT MIN(columna)
FROM tabla;

SELECT MAX(columna)
FROM tabla;

--SUM: Para sacar la suma de todos los valores de una categoría

SELECT SUM(columna)
FROM tabla;

--AVG: Para obtener la media de todos los valores de una categoría

SELECT AVG(columna)
FROM tabla;

--COUNT: Para contar los registros de esa columna

SELECT COUNT(columna)
FROM tabla;
*/

USE tienda;

SELECT *
FROM tienda.payments

SELECT MIN(amount) AS factura_minima
FROM tienda.payments; 

SELECT MAX(amount) AS maximo
FROM tienda.payments;

SELECT SUM(amount) AS suma
FROM tienda.payments;

SELECT AVG(amount) AS media
FROM tienda.payments;

SELECT COUNT(amount) AS numero_de_pagos
FROM tienda.payments;

SELECT
MIN(amount) AS Minimo,
MAX(amount) AS Maximo,
AVG(amount) AS Media,
SUM(amount) AS Suma,
COUNT(amount) AS numero_de_pagos
FROM tienda.payments;

 
/* ¿En qué se diferencias estas dos consultas?*/

SELECT COUNT(customer_number) AS numero_clientes
FROM tienda.customers;

SELECT COUNT(DISTINCT customer_number) AS registros_unicos
FROM tienda.customers;


SELECT COUNT(order_number)
FROM tienda.orders;

SELECT COUNT(DISTINCT order_number)
FROM tienda.orders;

/* Vamos a practicar con sakila */

SELECT *
FROM sakila.payment;

/*Quiero saber el total que se ha pagado en todos los alquileres*/

USE sakila;

SELECT SUM(amount) AS suma_de_alquiler
FROM sakila.payment;


/* Quiero saber cuánto es lo mínimo  y máximo que se ha pagado por un alquiler*/

SELECT MIN(amount) AS alquiler_minimo,
MAX(amount) AS alquiler_maximo,
AVG(amount) AS alquiler_medio,
COUNT(amount) AS numero_alquileres,
COUNT(DISTINCT amount) AS precios_diferentes
FROM sakila.payment;

/*Quiero saber la media de lo que se paga por alquiler*/


/*Quiero contar cuántos alquileres se han hecho*/




-- Vamos a ver ahora el GROUP BY

-- Vamos a la tabla empleados de tienda, a ver qué pinta tiene.*/

USE tienda;

SELECT *
FROM tienda.employees;

/*Ahora quiero ver cuántos empleados hay por cada puesto de trabajo.
Para eso tendré que agrupar por puesto de trabajo
Primero hay que definir el grupo, ¿por qué agrupamos? */

SELECT COUNT(DISTINCT employee_number) AS Numero_empleados,
job_title
FROM tienda.employees
GROUP BY job_title;

SELECT DISTINCT job_title
FROM tienda.employees;




/* Tenemos que preguntarnos:
- Por qué columna queremos agrupar
- Qué queremos ver (en este caso, el job title y el recuento distinto de empleados) 

El Group By siempre va con una función agregada,
como SUM, AVG, MIN, MAX o COUNT.


Veamos otro ejemplo:*/

SELECT *
FROM tienda.customers;

SELECT sales_rep_employee_number,
COUNT(DISTINCT customer_number) AS clientes_totales
FROM tienda.customers
WHERE sales_rep_employee_number IS NOT NULL
GROUP BY sales_rep_employee_number
HAVING clientes_totales > 6
ORDER BY clientes_totales DESC;


SELECT city, 
COUNT(DISTINCT customer_number) AS clientes_totales,
AVG(credit_limit) AS media_credito
FROM tienda.customers
GROUP BY city
HAVING media_credito > 600000
ORDER BY clientes_totales DESC;


/* Imaginaos que aquí quiero ver cuántos clientes hay por ciudad, ¿cómo lo haríamos? ¿Por qué columna agruparía? ¿Y la función agregada?*/


SELECT
city,
COUNT(DISTINCT customer_number) AS Numero_clientes
FROM tienda.customers
GROUP BY city;

/*¿y si queremos ordenar de más a menos?*/

SELECT
city,
COUNT(DISTINCT customer_number) AS Numero_clientes
FROM tienda.customers
GROUP BY city
ORDER BY
Numero_clientes DESC;

/*También puedo agrupar por dos columnas, podría agrupar por ciudad y estado. */

SELECT
city,
state,
COUNT(DISTINCT customer_number) AS Numero_clientes
FROM tienda.customers
GROUP BY city, state
ORDER BY
Numero_clientes DESC;

/*Ahora quiero que solo quiero que me muestre solo los resultados que no tengan NULO en estado. ¿Cómo lo haría?*/

SELECT
city,
state,
COUNT(DISTINCT customer_number) AS Numero_clientes
FROM tienda.customers
WHERE state IS NOT NULL
GROUP BY city, state
ORDER BY
Numero_clientes DESC;

/*El orden sería el siguiente

SELECT
columnas que queremos ver
funciones agregadas
FROM
WHERE
GROUP BY
ORDER BY */

#Dime qué cantidad de películas que duran más de 100 minutos hay en cada categoría
USE sakila;

SELECT 
rating,
COUNT(DISTINCT film_id) AS numero_pelis
FROM film
WHERE length > 100
GROUP BY rating
ORDER BY length ASC;

-- Yo puedo filtrar los datos ANTES de hacer una agrupación (con WHERE)
-- pero también puedo filtrar los datos ya dados con HAVING
-- WHERE y HAVING hacen lo mismo, pero en diferentes momentos de la consulta
-- Por ejemplo, una vez que me des el número de las películas por categoría, quiero ver solo las categorías con más de 120 pelis

SELECT 
rating,
COUNT(DISTINCT film_id) AS numero_pelis
FROM film
WHERE length > 100
GROUP BY rating
HAVING numero_pelis > 120
ORDER BY length ASC;

SELECT *
FROM sakila.payment;

-- ¿Qué estamos haciendo aquí? ¿Qué diferencia hay entre el filtro de WHERE y HAVING?
USE sakila;
SELECT staff_id,
COUNT(DISTINCT customer_id) AS clientes_por_trabajador
FROM payment
WHERE amount > 1
GROUP BY staff_id
HAVING clientes_por_trabajador > 5;


/* ¿Qué hacemos aquí? */

USE tienda;
SELECT
city,
COUNT(DISTINCT customer_number) AS Numero_clientes,
AVG(credit_limit) AS crédito_mínimo
FROM tienda.customers
WHERE state IS NOT NULL
GROUP BY city
HAVING Numero_clientes >= 3;


SELECT
city,
COUNT(DISTINCT customer_number) AS Numero_clientes,
AVG(credit_limit) AS crédito_mínimo
FROM tienda.customers
WHERE state IS NOT NULL
GROUP BY city, state
HAVING crédito_mínimo >= 100000 AND Numero_clientes > 0; 

/* En resumen:
WHERE filtra filas indivudales y HAVING filtra el resultado del GROUP BY


 CASE:
 -Sirve para usar condicional dentro de las consultas SQL
 -Podemos crear categorías en función de si unas condiciones se cumplen
 -Estos grupos no se crean en la BBDD, SOLO PARA VISUALIZARLOS EN PANTALLA, NO SE GUARDA 
 -Se utiliza con las palabras claves WHEN, THEN, ELSE, END AS
 

Quiero:
-Agrupar registros por credit_limit, pero es una variable numérica y yo lo que quiero es crear categorías
- Credito Alto, Credito Bajo y Crédito Medio */
SELECT *
FROM tienda.customers;

SELECT customer_name,
CASE
	WHEN credit_limit < 50000 THEN 'Credito_Bajo' -- Condición y el nombre de esa categoría
    WHEN credit_limit > 100000 THEN 'Credito_Alto' -- Condición y nombre de esa categoría
    ELSE 'Credito_Medio'                           -- Todo lo demás, entra aquí
    END AS CreditLimitTypes                        -- Y aquí le pongo el nombre de esa columna en la que irán las categorías (SOLO para verlo por pantalla, es como un AS)
FROM tienda.customers
ORDER BY credit_limit;

-- O que solo me enseñe la categoria que le he puesto
SELECT customer_name,
CASE
	WHEN credit_limit < 50000 THEN 'Credito_Bajo'
    WHEN credit_limit > 100000 THEN 'Credito_Alto'
    ELSE 'Credito_Medio'
    END AS CreditLimitTypes
FROM tienda.customers
ORDER BY credit_limit;

-- Quiero ver cuántos clientes hay por ciudad (agrupar por ciudad) y hacer categoría según la cantidad de clientes (con CASE)

SELECT *
FROM tienda.customers;


SELECT
city,
COUNT(DISTINCT customer_number) AS numero_clientes,
CASE
	WHEN COUNT(DISTINCT customer_number) < 2 THEN 'Popularidad_Baja'
	WHEN COUNT(DISTINCT customer_number) >= 4 THEN 'Popularidad_Alta'
    ELSE 'Popularidad_Media'
    END AS Popularidad
FROM tienda.customers
GROUP BY city;

--------------------------
/* Vamos a hacer un ejercicio resumen. A ver qué tenemos en esta tabla. 
Encontramos datos de pedido-producto, es decir, se repite el order_number por cada producto del pedido*/

SELECT *
FROM tienda.order_details;

/* Quiero tener una tabla con el order_number y el valor total del pedido */

SELECT
order_number,
SUM(price_each * quantity_ordered) AS Valor_total
FROM tienda.order_details
GROUP BY order_number;

/*Ahora quiero ver los pedidos que se han hecho y cuánto hemos ganado en total */

SELECT
COUNT(DISTINCT order_number) AS numero_pedidos_diferentes,
SUM(price_each * quantity_ordered) AS Valor_total
FROM tienda.order_details;

/* Sigamos con el ejemplo de sakila*/

SELECT *
FROM sakila.payment;

-- Aquí vimos el total del pago, pero
-- ¿y si quiero ver cuánto ha pagado cada cliente?


SELECT customer_id, 
SUM(amount) AS total_payment
FROM sakila.payment
GROUP BY customer_id;

-- Quiero ver el cliente que más ha pagado

SELECT customer_id, 
SUM(amount) AS total_payment
FROM sakila.payment
GROUP BY customer_id
ORDER BY total_payment DESC
LIMIT 1;
------------------------------------------------------------
-- Pero yo es que quiero ahora ponerle una condición
-- Quiero que me muestre lo pagado por cada cliente,
-- pero solo en los que el staff_id es 1

SELECT customer_id, SUM(amount) AS total_payment
FROM sakila.payment
WHERE staff_id = 1
GROUP BY customer_id
ORDER BY total_payment;

-- Ese cambio se hace antes de la agrupación. Pero qué pasa
-- si quiero filtrar los resultados de la agrupación?

SELECT customer_id, SUM(amount) AS total_payment
FROM sakila.payment
GROUP BY customer_id
HAVING total_payment > 100
ORDER BY total_payment;

-- Veamos cómo podríamos usar CASE aquí

SELECT customer_id, SUM(amount) AS total_payment,
	CASE 
		WHEN SUM(amount) < 30 THEN 'Bajo'
        WHEN SUM(amount) BETWEEN 30 AND 90 THEN 'Medio'
        WHEN SUM(amount) > 90 THEN 'Alto'
	END AS rental_level
FROM sakila.payment
GROUP BY customer_id
ORDER BY total_payment;