-- Ranking por calificación IMDb
SELECT titulo, rating_imdb,
       RANK() OVER (ORDER BY rating_imdb DESC) AS ranking_imdb
FROM Episodios;

-- Ranking por duración con DENSE_RANK
SELECT titulo, duracion,
       DENSE_RANK() OVER (ORDER BY duracion DESC) AS ranking_por_duracion
FROM Episodios;

-- Series con promedio IMDb > 8
SELECT 
titulo,
FROM Series
WHERE serie_id IN (
    SELECT serie_id
    FROM Episodios
    GROUP BY serie_id
    HAVING AVG(rating_imdb) > 8
);

-- Antigüedad de series
SELECT titulo,
       CASE WHEN año_lanzamiento <= 2010 THEN 'Antigua'
            ELSE 'Reciente' END AS Antigüedad
FROM Series;

-- Categoría de género
SELECT titulo,
       CASE WHEN genero = 'Drama' THEN 'Dramático'
            WHEN genero = 'Comedia' THEN 'Divertido'
            ELSE 'Otro' END AS CategoriaGenero
FROM Series;
-- Redondear rating hacia arriba
SELECT
titulo,
CEILING(rating_imdb) AS rating_redondeado
FROM Episodios;

-- Número de episodios y promedio IMDb por serie
WITH EpisodiosRecientes AS (
    SELECT serie_id, COUNT(episodio_id) AS num_episodios
    FROM Episodios
    GROUP BY serie_id
),
Calificaciones AS (
    SELECT serie_id, AVG(rating_imdb) AS promedio_imdb
    FROM Episodios
    GROUP BY serie_id
)
SELECT s.titulo, er.num_episodios, c.promedio_imdb
FROM Series s
JOIN EpisodiosRecientes er ON s.serie_id = er.serie_id
JOIN Calificaciones c ON s.serie_id = c.serie_id
ORDER BY c.promedio_imdb DESC, er.num_episodios DESC;

-- Series de los 3 géneros más frecuentes con promedio IMDb
SELECT s.titulo AS TituloSerie,
       s.año_lanzamiento AS AñoLanzamiento,
       s.genero AS Genero,
       AVG(e.rating_imdb) AS RatingPromedioIMDb
FROM Series s
JOIN Episodios e ON s.serie_id = e.serie_id
WHERE s.genero IN (
    SELECT genero
    FROM (
        SELECT genero, COUNT(*) AS cantidad_series
        FROM Series
        GROUP BY genero
        ORDER BY cantidad_series DESC
        LIMIT 3
    ) AS top3
)
GROUP BY s.serie_id
ORDER BY RatingPromedioIMDb DESC;