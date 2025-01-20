# Repaso JOIN
# CROSS JOIN
# NATURAL JOIN
# INNER JOIN
# LEFT JOIN
# RIGH JOIN
# FULL JOIN



/* Tenemos las tablas film, film category y category en sakila
Quiero una tabla que me diga el id de la película, su titulo y el nombre de su categoría, solo de los resultados en común */

USE sakila;

SELECT
* FROM film;

SELECT *
FROM film_category;

SELECT *
FROM category;

SELECT f.film_id AS id, 
f.title AS nombre_pelicula, 
c.name AS genero
FROM film f
INNER JOIN film_category fc
ON f.film_id = fc.film_id
INNER JOIN category c
ON c.category_id = fc.category_id;




/* Con Northwind, quiero una tabla donde tenga el nombre de los clientes y el número total de pedidos realizados,
pero solo quiero ver los que han hecho más de 10 pedidos y solo los clientes que hayan hecho pedidos*/

USE Northwind;

SELECT * FROM customers;

SELECT * FROM orders;

SELECT c.companyname, COUNT(DISTINCT o.orderid) numero_total_pedidos
FROM customers c
INNER JOIN orders o
ON c.customerid = o.customerid
WHERE c.city NOT IN ('Madrid', 'London', 'Berlin')
GROUP BY c.CompanyName
HAVING numero_total_pedidos > 10
ORDER BY numero_total_pedidos ASC;





SELECT
c.companyname,
o.shipcountry,
COUNT(DISTINCT o.orderid) as num_pedidos
FROM customers c
INNER JOIN orders o
ON c.customerid = o.customerid
WHERE c.city NOT IN ('Madrid', 'London')
GROUP BY c.companyname
HAVING num_pedidos >10
ORDER BY num_pedidos;

SELECT
c.companyname,
o.ShipCountry,
COUNT(DISTINCT o.orderid) as numero_total_pedidos
FROM customers c
INNER JOIN orders o
ON c.customerid = o.customerid
WHERE c.city NOT IN ('Madrid', 'London', 'Berlin')
GROUP BY c.CompanyName
HAVING numero_total_pedidos > 10
ORDER BY numero_total_pedidos ASC;




-- Encuentra los nombres de las categorías y la cantidad total de alquileres (rentals) por categoría que tengan más de 500 alquileres. 
-- Ordena el resultado por la cantidad de alquileres en orden descendente.
-- Tablas involucradas:

USE sakila;
SELECT * FROM film_category;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM category;


SELECT c.name nombre_categoria, COUNT(r.rental_id) numero_alquileres
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY nombre_categoria
HAVING numero_alquileres > 500
ORDER BY numero_alquileres DESC;

















-- Encuentra los actores cuyos nombres comienzan con la letra 'A' y calcula el promedio de la duración (length)
-- de las películas en las que han participado. Muestra el nombre completo del actor y el promedio de duración de las películas, 
-- ordenando los resultados por el promedio en orden descendente.

SELECT * FROM actor;
SELECT * FROM film_actor;
SELECT * FROM film;

CREATE TABLE nombre_tabla
AS
	SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre_actor, AVG(f.length) AS duracion_media
	FROM actor a
	INNER JOIN film_actor fa
	ON a.actor_id = fa.actor_id
	INNER JOIN film f
	ON fa.film_id = f.film_id
	WHERE a.first_name LIKE 'A%'
	GROUP BY nombre_actor
	ORDER BY duracion_media DESC;




-- Calcula el total de ingresos generados por cada película, incluyendo aquellas que no tienen ingresos registrados aún.
-- Muestra el título de la película y el total de ingresos, ordenando el resultado por los ingresos en orden descendente.

SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;
SELECT * FROM payment;

SELECT f.title AS titulo_pelicula, SUM(p.amount) AS cantidad_alquiler
FROM film f
LEFT JOIN inventory i
ON f.film_id = i.film_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
LEFT JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY titulo_pelicula
ORDER BY cantidad_alquiler DESC;







------
SELECT 
    c.CompanyName,
    o.OrderID,
    o.OrderDate,
    p.ProductName,
    od.Quantity,
    od.UnitPrice
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN Order_Details od ON o.OrderID = od.OrderID
LEFT JOIN Products p ON od.ProductID = p.ProductID;
---------------------------
SELECT c.name categoria, COUNT(DISTINCT rental_id) numero_alquileres
FROM category c
INNER JOIN film_category fc
ON fc.category_id = c.category_id
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r 
ON i.inventory_id = r.inventory_id
GROUP BY categoria
HAVING numero_alquileres > 500
ORDER BY numero_alquileres DESC;
----------------------
SELECT CONCAT(a.first_name,' ',a.last_name) AS nombre_actor , AVG(f.length) duracion_media
FROM actor a
INNER JOIN film_actor fa
ON fa.actor_id = a.actor_id
INNER JOIN film f
ON f.film_id = fa.film_id
WHERE a.first_name LIKE 'A%'
GROUP BY nombre_actor
ORDER BY duracion_media DESC;
---------------
SELECT f.title AS titulo, SUM(p.amount) AS ingresos_totales
FROM film f
LEFT JOIN inventory i
ON i.film_id = f.film_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
LEFT JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY titulo
ORDER BY ingresos_totales ASC;
