#Con sakila

# Encuentra todas las películas que comienzan con la letra A 


#Encuentra todas las películas que tienen al menos una vocal en su título 


#Encuentra las películas cuyo título tenga al menos 10 caracteres


#Encuentra las películas que tengan la silaba "the" en cualquier parte del título


-----------------------------
SELECT title
FROM film
WHERE title REGEXP '^A';

SELECT title
FROM film
WHERE title REGEXP '[aeiouAEIOU]';

SELECT title
FROM film
WHERE title REGEXP '.{10,}';

SELECT title
FROM film
WHERE title LIKE '%the%';
-----

#Repaso general

#Encuentra el nombre y apellido del actor o actores que apaerecen en la película 'OTHERS SOUP'
#Pista: el nombre y apellido están en la tabla actor, en la tabla film_actor están las combinaciones de película y actor
#y en la tabla film está el nombre de la tabla


#Muestra todas las películas que contengan la palabra "hood" o "main" en su desdripcion

#Muestra las películas cuyo año de lanzamiento sea entre 200 y 2005


#Encuentra el titulo de las peliculas cuya categoria sea Children
#Pista, el nombre de pelicula está en film, el id de categoria en film category y el nombre de categoria en category


#Selecciona los diferentes rating de peliculas

#Busca los titulos de peliculas que tenga un rating de PG y su duracion sea de más de 90 min


#MEncuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.

SELECT * FROM category;

SELECT * FROM film_category;



------------------------
SELECT * FROM film;
SELECT a.first_name, a.last_name
FROM actor as a
JOIN film_actor as fa ON a.actor_id = fa.actor_id
JOIN film as f ON fa.film_id = f.film_id
WHERE f.title = 'SWEET BROTHERHOOD';