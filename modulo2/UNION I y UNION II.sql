/* Hoy vamos a ver cómo UNIR TABLAS

Para unir tablas utilizamos la palabra clave JOIN
y hoy veremos tres tipos de JOIN

-- CROSS JOIN: Combina cada fila de una tabla con todas las filas de la otra

Ej:
Tengo una tabla llamada amigas con las columnas

nombre  apellido
Ana     Martín
Juana   Cuevas
Lucía	Sánchez



Tengo otra tabla llamada hobbies con las columnas



hobbie              lugar
juegos de mesa      Sevilla
escape rooms        Madrid
ir al cine          Galicia
*/ 
Si hago un CROSS JOIN lo que hago es que veo todas las posibilidades de unir la primera tabla con la segunda,


nombre   apellido   hobbie           lugar
Ana      Martín     juegos de mesa   Sevilla
Ana      Martín     escape rooms     Madrid
Ana      Martín     ir al cine       Galicia
Juana   Cuevas      juegos de mesa   Sevilla
Juana   Cuevas      escape rooms     Madrid
Juana   Cuevas      ir al cine       Galicia
Lucía   Sánchez     juegos de mesa   Sevilla
Lucía  Sánchez     escape rooms      Madrid
Lucía   Sánchez     ir al cine       Galicia

-- CROSS JOIN
Imaginaos que lo que quiero es que de cada color (son jerseis) haya de todas las tallas

*/

Tabla color
|colores   |
|----------|
|rojo      |
|azul      |
|amarillo  |

Tabla talla
|tallas    |
|----------|
|S         |
|M         |
|L         |

|colores   |tallas   |
|----------|---------|
|rojo      | S       |
|azul      | S       |
|amarillo  | S       |
|rojo      | M       |
|azul      | M       |
|amarillo  | M       |
|rojo      | L       |
|azul      | L       |
|amarillo  | L       |

-- Y en código, ¿cómo sería esto?
-- Selecciono las columnas de cada tabla que quiero combinar
-- En el FROM nombro la primera tabla
-- y en el CROSS, la segunda.


SELECT
	tabla1.columna1, -- Las columnas a unir: como hacemos referencias a columnas de dos tablas hay que poner nombre_tabla.nombre_columna
    tabla1.columna2,
    tabla2.columna1,
    tabla2.columna2
FROM tabla1          -- Primera tabla
CROSS JOIN tabla2;  -- Segunda tabla

USE sakila;

SELECT *
FROM actor;

SELECT *
FROM film;

SELECT actor_id, first_name, last_name
FROM actor;

SELECT film_id, title
FROM film;

SELECT 
    actor.first_name AS nombre,
    actor.last_name AS apellido,
    film.title AS pelicula
FROM 
    actor
CROSS JOIN 
    film;

-- EXPLICACIÓN:
-- actor contiene información de actores y film de películas
-- CROSS JOIN combina todas las filas de la tabla actor con todas las filas de la tabla film, aunque no tengan nada en común
-- Seleccionamos las columnas que queremos combinar
-- El resultado: la tabla actor tiene 200 filas  y la de film 1000, pues el resultado son 200 000 (200 x 1000)
-- Cada fila es el resultado de emparejar el actor con una película

/* Para selecionar las columnas que queremos mostrar, nombro la tabla.nombre_columna
Otros ejemplos seria: Una tabla de productos y quiero unirla a todas las promociones.

SELECT
productos.product_id,
productos.nombre,
promociones.promocion_id
FROM productos
CROSS JOIN promociones;

A veces el resultado va a ser demasiado largo y tendremos que utilizar filtros, por ejemplo con WHERE

Veamos un ejemplo con nuestras tablas*/ 

SELECT * FROM tienda.customers;

SELECT * FROM tienda.offices;

USE tienda;
SELECT
customers.customer_name,
offices.office_code
FROM customers
CROSS JOIN offices
WHERE customers.country = 'France';



/* NATURAL JOIN:
- Unimos dos tablas y busca automáticamente una columna con el mismo nombre en ambas tablas
para combinar los datos */

Tabla clientes
|id_cliente|nombre   |
|----------|---------|
|1    	   | Carol   |
|2         | Sonia   |
|3         | Laura   | 
 
Tabla pedidos
|id_pedido |id_cliente| producto |
|----------|----------|----------|
|2233      | 1        | Movil    |
|2234      | 3        | Portatil |
|2235      | 2        | Cascos   |

/* ¿Qué columna tienen en común?: id_cliente, así que las puedo unir por esa, para obtener el nombre
Se unen las tablas a través de la columna en común

SELECT
clientes.id_cliente
clientes.nombre
pedidos.producto
FROM clientes
NATURAL JOIN pedidos;

Ó si quiero seleccionar todas las columnas de ambas tablas

SELECT *
FROM clientes
NATURAL JOIN pedidos;

*/


|id_cliente|nombre    | id_pedido| producto |
|----------|----------|----------|----------|
|1         | Carol    | 2233     | Movil    |
|3         | Laura    | 2234     | Portatil |
|2         | Sonia    | 2235     | Cascos   |


/* 

Es decir, la estructura es

SELECT
tabla1.columna1,
tabla1.columna2,
tabla2.columna1,
tabla2.columna2
FROM tabla1,
NATURAL JOIN tabla2;


El Natural Join tenemos que hacerlo entre tablas que tengan una columna que se llama igual
y tiene el mismo tipo de dato

- Combila las filas de dos tablas basándose automáticamente en las columnas con el mismo nombre
- NO REQUIERE que especifiquemos explícitamente las columnas de unión
- Si las tablas no tienen columnas con nombres comunes, el resultado será un producto cartesiano */

USE sakila;

SELECT *
FROM city;

SELECT *
FROM address;

SELECT
city.city_id,
city.city,
address.address,
address.district
FROM city
NATURAL JOIN address;


-- El NATURAL JOIN: combina dos tablas basándose automáticamente en las columnas comunes que tienen el mismo nombre y tipo de dato
-- Es una forma más sencilla de hacer un INNER JOIN cuando las columnas en común se llaman iguales

---------------------
USE promo_47;
CREATE TABLE departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);


CREATE TABLE employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES departments(DepartmentID)
);

INSERT INTO departments (DepartmentID, DepartmentName)
VALUES
(101, 'HR'),
(102, 'IT');


INSERT INTO employees (EmployeeID, EmployeeName, DepartmentID)
VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);
-------------------------------

USE promo_47;

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT *
FROM employees
NATURAL JOIN departments;

SELECT 
    employees.EmployeeName,
    departments.DepartmentName
FROM employees
NATURAL JOIN departments;


-- Otra manera de hacerlo para no poner el nombre completo de la tabla


SELECT 
    e.EmployeeName AS nombre,
    d.DepartmentName AS departamento
FROM 
    employees e
NATURAL JOIN 
    departments d;
    
/* INNER JOIN:

-Igual que NATURAL JOIN pero aquí la columna en común no se llama igual, así que tengo que especificarla en la cláusula ON
 */

Tabla usuarios
|id        |nombre    | edad     |
|----------|----------|----------|
|1234      | Rosa     | 53       |
|1235      | Carmen   | 36       |
|1236      | Marta    | 30       |

Tabla pedidos
|id_pedido |id_cliente | producto |
|----------|-----------|----------|
|2233      | 1234      | Movil    |
|2234      | 1235      | Portatil |
|2235      | 1236      | Cascos   |
|2236      | 1235      | Teclado  |

/* id y id_cliente son lo mismo, pero se llaman diferente. Podemos unir las tablas por esa columna.
No importa el orden de las tablas porque vamos a obtener los datos en común */


SELECT
usuarios.nombre
pedidos.*
FROM pedidos
INNER JOIN usuarios
ON pedidos.id_usuario = usuarios.id;

Resultado:
|id_pedido |id_cliente | producto | nombre  |
|----------|-----------|----------|---------|
|2233      | 1234      | Movil    | Rosa    |
|2234      | 1235      | Portatil | Carmen  |
|2235      | 1236      | Cascos   | Marta   |
|2236      | 1235      | Teclado  | Carmen  |

/* Con esta tabla ya podemos ver por ejemplo qué ha comprado cada cliente
IMPORTANTE: Solo nos va a mostrar la información que aparezca en las dos tablas.
Si un id, aparece en una pero en otra no, no nos la muestra.


-- Ejemplo de INNER JOIN con sakila
-- INNER JOIN: combinación de tablas que devuelve solo las filas que tienen coincidencias en ambas tablas
-- Si una fila de una tabla no encuentra coincidencia en la otra tabla, no aparecerá en el resultado
*/
USE tienda;

SELECT * 
FROM employees;

SELECT *
FROM customers;

-- Selecciona el ID, nombre, apellidos de las empleadas y el ID de cada cliente asociado a ellas

SELECT employees.employee_number, employees.first_name, employees.last_name, customers.customer_number
FROM employees 
INNER JOIN customers 
ON employees.employee_number = customers.sales_rep_employee_number;

SELECT e.employee_number AS trabajador,
e.first_name AS nombre,
e.last_name AS apellido,
c.customer_number AS cliente
FROM employees e
INNER JOIN customers c 
ON e.employee_number = c.sales_rep_employee_number;

 
---------------------------------------------
UNION II


/* Repasemos:

CROSS JOIN devuelve un producto cartesiano de las combinaciones de todas las filas de una tabla con las de otra tabla.

INNER JOIN combina datos de dos tablas y solo devuelve las filas que tengan coincidencia en ambas tablas. 
Es decir, si combinamos pedidos y productos, no va a mostrar ningún registro de un productos que no se hayan pedido. 
En INNER JOIN usamos la clausula ON donde le pasamos la columna que tienen en comun ambas tablas,
como ON pedidos.id = productos.id_pedidos

En NATURAL JOIN no necesitamos decir cual es la columna de unión, ya que se llaman igual.
Une las tablas por la columna que se llama igual y tiene el mismo tipo de dato.
Si no es así, no funciona.
Además, también muestra solo las filas que tienen coincidencias en ambas tablas.

-- UNION II


Hoy veremos:

-- LEFT JOIN
-- RIGHT JOIN
-- FULL JOIN
-- SELF JOIN
-- Las mas comunes son INNER JOIN y LEFT JOIN

-- LEFT JOIN: Pido los resultados que tengan en común (como el INNER JOIN), pero también las columnas
-- de la tabla de la izquierda (la primera, a la que llamo desde FROM), aunque no tengan corresponendencia con las de la derecha
-- Me da igual si las columnas se llaman iguales o no, SIEMPRE paso el ON tabla1.columna1 = tabla2.columna2
*/ 

Tabla usuarios
|id        |nombre    |
|----------|----------|
|1234      | Rosa     |
|1235      | Carmen   |
|1236      | Marta    |

Tabla pedidos
|id_pedido |id_cliente | producto |
|----------|-----------|----------|
|2233      | 1234      | Movil    |
|2235      | 1236      | Cascos   |


/*Aquí en un INNER JOIN obtendría solo los datos en común, es decir, 
la clienta 1235 no aparecería.
Veamos cómo se haría un LEFT JOIN*/

SELECT
usuarios.nombre,
pedidos.productos
FROM usuarios
LEFT JOIN pedidos
ON usuarios.id = pedidos.id_cliente


RESULTADO

|id        |nombre    | producto|
|----------|----------|---------|
|1234      | Rosa     | Móvil   |
|1235      | Carmen   | NULL    |
|1236      | Marta    | Cascos  |

-- Mantengo todas las de la tabla de la izquierda (la primera en pasarle) 
-- aunque no tengan correspondencia con la otra tabla con la que la hemos unido


-- Imaginaos que hay alguna alumna que ha empezado más tarde o que no se ha presentado a algún examen
-- En ese caso tendría que hacer un LEFT JOIN donde la tabla LEFT sea la de alumnas, porque quiero que aparezcan todos los nombres

Tabla alumnas
|id        |nombre    | apellido| notas_mod1
|----------|----------|---------|
|1         | Rosa     | López   | 5
|2         | Carmen   | Correal | 8
|3         | Marta    | Cuevas  |  NULL
 5          Lorena      Martin   NULL


Tabla notas
|id_alumna |nota_mod1 | nombre   apellido
|----------|----------|
|1         | 5        | Rosa
|2         | 8        | Carmen
5           NULL       Lorena 
7          9           NULL      NULLL
        

SELECT a.*,
n.nota_mod1
FROM alumnas a
LEFT JOIN notas n
ON a.id = n.id_alumna;

-- Si yo hago un INNER JOIN, perdería a Marta
-- La estructura seria

SELECT alumnas.*
notas.nota_mod1
FROM alumnas
LEFT JOIN notas
ON alumnas.id = notas.id_alumnas -- Aunque las columnas se llamasen igual, tendría que especificar que son la misma


-- Ahora vamos a ver un ejemplo con las tablas de clientes y pedidos de tienda
-- Queremos una tabla donde veamos los clientes y sus pedidos hechos, pero también los clientes que aún no hayan hecho ningún pedido

USE tienda;

SELECT *
FROM tienda.customers;

SELECT *
FROM tienda.orders;

SELECT c.customer_number, 
c.customer_name,
o.order_number
FROM customers c
LEFT JOIN orders o
ON c.customer_number = o.customer_number;



-- Vemos que se relacionan a partir del customer_number

SELECT
customers.customer_number,
customers.customer_name,
orders.order_number,
orders.order_date
FROM customers
LEFT JOIN orders
ON customers.customer_number = orders.customer_number;

-- Si observamos, veremos algún nulo, porque no todos los clientes han hecho pedidos
-- Podríamos hacer varios JOIN

USE world;

SELECT *
FROM city;

SELECT *
FROM country;


SELECT *
FROM countrylanguage

SELECT city.name AS Ciudad,
city.district AS Distrito,
country.name AS Pais,
country.continent AS Continente,
countrylanguage.Language AS Idioma
FROM city
LEFT JOIN country
ON city.country_code = country.code
LEFT JOIN countrylanguage
ON city.country_code = countrylanguage.CountryCode;

-- Las tres tablas se pueden relacionar entre ellas a través del country code
-- Pero también podemos usar varios LEFT JOIN que no tengan columnas en común, pero hay una tabla intermedia en la que sí

USE northwind;

-- Quiero ver en una tabla el id del pedido, la fecha del pedido, el nombre del cliente (empresa) y del empleado que le ha atendido
-- Quiero que aparezcan todos los clientes, aunque no hayan hecho compra
-- ¿Qué necesito de cada tabla?

SELECT *
FROM Orders;

SELECT *
FROM Customers;

SELECT *
FROM Employees;


SELECT Orders.OrderID AS id_pedido,
Orders.OrderDate AS fecha,
    Customers.CompanyName AS Cliente,
Employees.FirstName AS Trabajador
FROM 
    Customers
LEFT JOIN 
    Orders
ON Orders.CustomerID = Customers.CustomerID
LEFT JOIN 
    Employees
ON 
    Orders.EmployeeID = Employees.EmployeeID
ORDER BY 
    Orders.OrderDate;

-- RIGHT JOIN: Igual, pero la tabla "principal" es la segunda, o la de la "derecha"
-- Si hay registros que están en la segunda, pero no en la primera, aparecen igualmente los de la "segunda" o "derecha"

Si tenemos una
Tabla empleados

-- LEFT JOIN

SELECT e.*, d.nombre AS nombre_departamento
FROM empleados e
LEFT JOIN departamentos d
ON e.id_departamento = d.id_departamento;

id_empleado  nombre  id_departamento nombre_departamento
1            Juana    23               Marketing
2            Luisa    26               Ventas
3            Lucía    NULL             NULL

Tabla departamentos
id_departamento nombre
23              Marketing             
33              Recursos Humanos      
26              Ventas    

-- RIGHT JOIN
SELECT e.*, d.nombre AS nombre_departamento
FROM empleados e
RIGHT JOIN departamentos d
ON e.id_departamento = d.id_departamento;

id_empleado  nombre  id_departamento nombre_departamento
1            Juana    23               Marketing
2            Luisa    26               Ventas
NULL         NULL     33               Recursos Humanos   

-- INNER JOIN

SELECT e.*, d.nombre AS nombre_departamento
FROM empleados e
INNER JOIN departamentos d
ON e.id_departamento = d.id_departamento;

id_empleado  nombre  id_departamento nombre_departamento
1            Juana    23               Marketing
2            Luisa    26               Ventas


Tabla departamentos
id_departamento nombre
23              Marketing             
33              Recursos Humanos      
26              Ventas     

-- FULL JOIN

SELECT e.*, d.nombre AS nombre_departamento
FROM empleados e
LEFT JOIN departamentos d
ON e.id_departamento = d.id_departamento
UNION
SELECT e.*, d.nombre AS nombre_departamento
FROM empleados e
RIGHT JOIN departamentos d
ON e.id_departamento = d.id_departamento;

id_empleado  nombre  id_departamento nombre_departamento
1            Juana    23               Marketing
2            Luisa    26               Ventas
3            Lucía    NULL             NULL
NULL         NULL     33               Recursos Humanos   

           











SELECT
empleados.*
departamento.nombre AS nombre_departamento
FROM empleados
RIGHT JOIN departamentos
ON empleados.id_departamento = departamentos.id_departamento;

-- Aquí la tabla "principal" es la segunda, es decir, departamentos
-- El resultado sería

id_empleado  nombre  id_departamento  nombre_departamento
1            Juana   23               Marketing
2            Luisa   26               Ventas
NULL		NULL	 33				  Recursos Humanos


-- Ejemplo de RIGHT JOIN con Northwind
USE northwind;

SELECT 
    Shippers.ShipperID,
    Shippers.CompanyName AS ShipperName,
    Orders.OrderID,
    Orders.OrderDate
FROM 
    Orders
RIGHT JOIN 
    Shippers
ON 
    Orders.ShipVia = Shippers.ShipperID
ORDER BY 
    Shippers.CompanyName;


-- FULL JOIN se devuelven los registros de ambas tablas, aunque no tenga correspondencia en la otra
-- Es como si hiciéramos un left join y un right join, uno encima del otro
-- Tenemos toda la info, tanto lo que tienen en común, como los que tienen datos en una tabla, pero no en otra /*


SELECT
tabla1.columna1,
tabla1.columna2,
tabla2.columna1
FROM tabla1
LEFT JOIN tabla2
ON tabla1.columna1 = tabla2.columna1
UNION
SELECT
tabla1.columna1,
tabla1.columna2,
tabla2.columna1
FROM tabla1
RIGHT JOIN tabla2
ON tabla1.columna1 = tabla2.columna1;


Tabla empleados
id_empleado  nombre  id_departamento
1            Juana    23
2            Luisa    26
3            Lucía    NULL

Tabla departamentos
id_departamento nombre
23              Marketing
33              Recursos Humanos
26              Ventas

-- ¿Cómo se haría un FULL JOIN de esta tabla?

SELECT
empleados.nombre AS empleado,
departamentos.nombre AS departamento
FROM empleados
LEFT JOIN departamentos
ON empleados.id_departamento = departamentos.id_departamentos
UNION
SELECT
empleados.nombre AS empleado,
departamentos.nombre AS departamento
FROM empleados
RIGHT JOIN departamentos
ON empleados.id_departamento = departamentos.id_departamento;

-- El resultado sería los comunes de los dos y los no comunes

empleado  departamento
Juana	  Marketing
Luisa	  Ventas
Lucía     NULL
NULL	  Recursos Humanos


-- FULL JOIN: devuelve todas las filas de ambas tablas
-- Si una fila de la tabla izquierda tiene coincidencia con la derecha, se combinan
-- Si una tabla izquierda no tiene coincidencia con la tabla derecha, aparece igualmente aunque el valor para la tabla derecha sea NULL
-- Al revés igual
-- Es decir: devuelve todas las filas de ambas tablas, las que tienen coincidencia y las que no


USE sakila;
SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    film_actor.film_id
FROM 
    actor
LEFT JOIN 
    film_actor
ON 
    actor.actor_id = film_actor.actor_id
UNION
SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    film_actor.film_id
FROM 
    actor
RIGHT JOIN 
    film_actor
ON 
    actor.actor_id = film_actor.actor_id;

-- ¿Cómo podríamos añadir en el ejercicio anterior alias?

-- SELF JOIN
-- En vez de combinar dos tablas diferentes, combinamos la misma tabla consigo misma
-- Como estamos trabajando con la misma tabla dos veces, necesitamos un alias

-- En la tabla de employees de Northwind hay una columna llamada ReportsTo que hace referencia al supervisor de esa persona
-- Si quierámos ver en una fila el trabajador y su supervisor, podríamos hacer lo siguiente:

USE northwind;

SELECT *
FROM Employees;

SELECT 
    e1.FirstName AS EmployeeName,
    e1.LastName AS EmployeeLastName,
    e2.FirstName AS ManagerName,
    e2.LastName AS ManagerLastName
FROM 
    Employees AS e1, Employees AS e2
WHERE 
    e1.ReportsTo = e2.EmployeeID;
