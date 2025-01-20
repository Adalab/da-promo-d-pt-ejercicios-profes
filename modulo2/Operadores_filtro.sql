-- Hoy vamos a ver operadores especiales de filtro: para ayudarnos a buscar y filtrar datos de manera más eficiente. Veremos:


-- UNION / UNION ALL
-- IN/ NOT IN
-- LIKE/NOT LIKE
-- REGEX



-- UNION/ UNION ALL

-- UNION: sirve para combinar resultados de dos o más consultas en un solo conjunto de datos.
-- Además, también ELIMINA LOS DUPLICADOS
-- Reglas:
	-- Ambas consultas necesitan el mismo número de columnas
    -- Las columnas deben ser del mismo tipo de dato
    -- El orden importa
    -- El nombre de las columnas será el nombre de las columnas de la primera consulta
    -- No es necesario que el nombre de las columnas coincidan
    -- Esta unión no se guarda, solo se muestra, luego veremos como guardarla


SELECT
columna1,
columna2
FROM tabla1
UNION
SELECT
columna1,
columna2
FROM tabla2

-- Tenemos dos tablas:

Tabla ventas_2023
id_venta  fecha        cantidad
1         2023-01-15    2000
2         2023-05-15    5000
3         2023-09-30    4000
11        2024-01-15    1000    -- Esta, por lo que sea, se nos ha colado aquí

Tabla ventas_2024
id          fecha       cantidad
11          2024-01-15  1000
12          2024-05-15  8000
13          2024-10-01  5000


SELECT
id_venta,
fecha,
cantidad
FROM ventas_2023
UNION
SELECT
id,
fecha,
cantidad
FROM ventas_2024;

-- RESULTADO: Es como poner una debajo de otra: 


id_venta  fecha        cantidad
1         2023-01-15    2000
2         2023-05-15    5000
3         2023-09-30    4000
11        2024-01-15    1000
12        2024-05-15    8000
13        2024-10-01    5000

-- De la BBDD sakila, queremos una tabla con los nombres y apellidos de los actores de la tabla actor y de los clientes de la tabla customer 
-- Ambos tienen columna de first_name y last_name

USE sakila;

SELECT * FROM actor;

SELECT * FROM customer;

SELECT first_name,
last_name
FROM actor
UNION
SELECT first_name,
last_name
FROM customer;




SELECT 
    first_name, 
    last_name
FROM customer
UNION
SELECT 
    first_name, 
    last_name
FROM actor;

-- Si qusieramos guardar este resultado en una tabla nueva
USE bd_prueba;

CREATE TABLE nombres AS
SELECT
    first_name, 
    last_name
FROM customer c
UNION
SELECT 
    first_name, 
    last_name
FROM actor;

-- UNION ALL: Igual que UNION, pero mantiene los valores duplicados
-- Y para guardar, haríamos lo mismo

SELECT columnas
FROM tabla1
UNION ALL
SELECT columnas
FROM tabla2;

SELECT 
    first_name AS nombre, 
    last_name AS apellido
FROM customer
UNION ALL
SELECT 
    first_name, 
    last_name
FROM actor;


-- IN 
  -- WHERE me permite poner una condición, por ejemplo WHERE ciudad = "Paris", ¿y si quiero poner más de una opción?
  -- WHERE city IN ("Paris", "Madrid", "Berlin")
  -- En resumen: se usa con el WHERE para pasarle entre paréntesis varias opciones
  
  SELECT columnas
  FROM tabla
  WHERE columna IN (valor1, valor2, valor3);
  
  -- NOT IN: igual, pero para que esos mismos no aparezcan
  
  SELECT columnas
  FROM tabla
  WHERE columna NOT IN (valor1, valor2, valor3);
  
  -- ¡CUIDADO! Asegurarnos de que lo escribimos bien
  
USE sakila;

-- Quiero los resultados de los actores Mary, John y Linda

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM customer
WHERE first_name IN ('Mary', 'John', 'Linda');

SELECT 
    film_id, 
    title, 
    rental_rate
FROM film
WHERE rental_rate IN (0.99, 2.99, 4.99)
ORDER BY rental_rate;

-- Quiero todos los resultados menos Nick, Scarlett y Emma
SELECT 
    actor_id, 
    first_name, 
    last_name
FROM actor
WHERE first_name NOT IN ('Nick', 'Scarlett', 'Emma');

-- Quiero todos los resultados menos los que tengan como apellido Smith, Johnson y Brown
SELECT 
    actor_id, 
    first_name, 
    last_name
FROM actor
WHERE last_name NOT IN ('Smith', 'Johnson', 'Brown');

-- LIKE, NOT LIKE
-- Nos permiten buscar patrones dentro de nuestras tabla
-- Sobre todo sirve cuando no sabemos con precisión que estámos buscando
-- Va acompañado de estos comodines: 
		-- % representa cualquier caracter(incluyendo ninguno) "navid%" buscamos algo que empiece por navid, pero me da igual de qué venga después o si no viene nada
        -- representa justo un caracter: "C__", buscamos algo que empiece por C y tenga dos caracteres más
        -- "r__%"   
-- Insensible a mayúsculas o minúsculas

SELECT
columnas
FROM tabla
WHERE columna LIKE 'patron';

-- Quiero los resultados de los nombres que empiecen por J

USE sakila;

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM customer
WHERE first_name LIKE 'J%';

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM customer
WHERE first_name LIKE 'D____';

SELECT 
    film_id, 
    title
FROM film
WHERE title LIKE 'D____%';

SELECT 
    address_id, 
    address
FROM address
WHERE address NOT LIKE '%123%';

SELECT 
    actor_id, 
    first_name, 
    last_name
FROM actor
WHERE last_name LIKE '%son';

SELECT 
    film_id, 
    title
FROM film
WHERE title NOT LIKE '%The%';

-- Con el LIKE no podemos usar IN
SELECT 
    actor_id, 
    first_name, 
    last_name
FROM actor
WHERE last_name LIKE 'Jo%'
   OR last_name LIKE 'Wi%'
   OR last_name LIKE 'Sm%';
   
-- REGEX
-- Nos permite buscar patrones más complejos de manera simple
-- Podemos definir reglas específicas para buscar dentro de nuestras columnas
-- Insensible mayúsculas y minúsculas

SELECT columnas
FROM tabla
WHERE columna REGEXP 'patron'

/* Operadores
. --> un caracer cualquiera
* --> el caracter o patrón anterior puede aparecer 0 o más veces
+ --> el caracter o patrón anterior puede aparecer una o más veces
? --> el caracter o patrón anterior puede aparecer 0 o 1 vez
| --> separa alternativa de patrones. "esto o esto"
[] --> agrupa un conjunto de caracteres validos en una posicion específica
^ --> el aracter o patrón siguiente debe aparecer al comienzo
$ --> el caracter o patrón anterior debe aparecer al final
{n} --> el caracter o patron anterior debe aparecer n veces

-- REVISAR EN GITBOOK (no podemos sabérnoslos todos) */

SELECT 
    film_id, 
    title
FROM film
WHERE title REGEXP 'Star|Moon|Sun';

SELECT 
    film_id, 
    title
FROM film
WHERE title REGEXP '^[Z|H]';

SELECT 
    actor_id, 
    first_name, 
    last_name
FROM actor
WHERE last_name REGEXP 'son$';

SELECT 
    address_id, 
    address
FROM address
WHERE address REGEXP '[0-9]';

-- Titulos que tengan exactamente 10 caracteres
SELECT 
    film_id, 
    title
FROM film
WHERE title REGEXP '^.{10}$';

SELECT 
    film_id, 
    title
FROM film
WHERE title NOT REGEXP '[0-9]';

SELECT 
    actor_id, 
    first_name, 
    last_name
FROM actor
WHERE last_name REGEXP 'th[aeiou]';

SELECT 
    actor_id, 
    first_name, 
    last_name
FROM actor
WHERE last_name REGEXP '^[aeiou]';

SELECT customer_id,
first_name, 
last_name
FROM customer
WHERE first_name REGEXP '[aei]u' OR last_name REGEXP '[aei]u';


