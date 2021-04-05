--1. Crear base de datos llamada películas (1 punto)
CREATE DATABASE peliculas;
\c peliculas;

--2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,determinando la relación entre ambas tablas. (2 puntos)
CREATE TABLE pelicula(id INT PRIMARY KEY,pelicula VARCHAR(100), agno_estreno SMALLINT, director VARCHAR(100));
CREATE TABLE reparto(id_pelicula INT,nombre_actor VARCHAR(100), FOREIGN KEY (id_pelicula) REFERENCES pelicula(id));

--3. Cargar ambos archivos a su tabla correspondiente (1 punto)

COPY pelicula FROM '/home/nachorivas/Escritorio/Apoyo Desafío 2 -  Top 100/peliculas.csv' csv HEADER;
COPY reparto FROM '/home/nachorivas/Escritorio/Apoyo Desafío 2 -  Top 100/reparto.csv' csv;

--4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,año de estreno, director y todo el reparto. (0.5 puntos)
SELECT * FROM pelicula FULL JOIN reparto ON pelicula.id=reparto.id_pelicula WHERE pelicula.pelicula = 'Titanic';
--5. Listar los titulos de las películas donde actúe Harrison Ford.(0.5 puntos)
SELECT id,pelicula FROM pelicula WHERE id IN (SELECT id_pelicula FROM reparto WHERE nombre_actor='Harrison Ford');
--6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en eltop 100.(1 puntos)
SELECT director, COUNT(*) FROM pelicula GROUP BY director ORDER BY count DESC LIMIT 10;
--7. Indicar cuantos actores distintos hay (1 puntos)
SELECT COUNT(DISTINCT nombre_actor) FROM reparto;
--8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas portítulo de manera ascendente.(1 punto)
SELECT pelicula FROM pelicula WHERE agno_estreno BETWEEN '1990' AND '1999' ORDER BY pelicula ASC;
--9. Listar el reparto de las películas lanzadas el año 2001 (1 punto)
SELECT nombre_actor FROM reparto WHERE id_pelicula IN (SELECT id FROM pelicula WHERE agno_estreno=2001);
--10. Listar los actores de la película más nueva (1 punto)
SELECT nombre_actor,FROM reparto WHERE id_pelicula IN (SELECT id FROM pelicula WHERE agno_estreno IN(SELECT MAX(agno_estreno) FROM pelicula));