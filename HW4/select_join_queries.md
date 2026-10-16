## 1. SELECT





### 1.1. Выборка всех данных из таблицы





**Запрос 1. Вывести всю информацию о песнях.\*\*





SQL













```

SELECT *

FROM song;



```











**Запрос 2. Вывести всю информацию об альбомах.**





SQL













```

SELECT *

FROM album;



```











### 1.2. Выборка отдельных столбцов





**Запрос 1. Вывести названия песен и их длительность в секундах.**





SQL













```

SELECT title, duration_sec

FROM song;



```











**Запрос 2. Вывести имена исполнителей и годы их основания.**





SQL













```

SELECT name, formed_year

FROM artist;



```











### 1.3. Присвоение новых имён столбцам при формировании выборки





\*\*Запрос 1. Вывести названия альбомов и годы выпуска под новыми именами столбцов.**





SQL













```

SELECT title AS album_title,

&#x20;      release_year AS year_released

FROM album;



```











**Запрос 2. Вывести названия песен и их номера в альбоме.**





SQL













```

SELECT title AS song_title,

&#x20;      track_number AS song_number

FROM song;



```











### 1.4. Выборка данных с созданием вычисляемого столбца





**Запрос 1. Вывести длительность песен также в минутах.**





SQL













```

SELECT title,

&#x20;      duration_sec,

&#x20;      duration_sec / 60.0 AS duration_min

FROM song;



```











**Запрос 2. Для каждого исполнителя рассчитать, сколько лет прошло с года его основания до 2026 года.**





SQL













```

SELECT name,

&#x20;      formed_year,

&#x20;      2026 - formed_year AS years_since_formed

FROM artist;



```











### 1.5. Выборка данных, вычисляемые столбцы и математические функции





**Запрос 1. Вывести длительность песен в минутах, округлив её до двух знаков после запятой.**





SQL













```

SELECT title,

      duration_sec,

     ROUND(duration_sec / 60.0, 2) AS duration_min

FROM song;



```











**Запрос 2. Вывести разницу между годом выпуска альбома и 1970 годом.**





SQL













```

SELECT title,

release_year,

ABS(release_year - 1970) AS years_from_1970
FROM album;



```











### 1.6. Выборка данных по условию





**Запрос 1. Найти песни длительностью более пяти минут.**





SQL













```

SELECT title, duration_sec

FROM song

WHERE duration_sec > 300;



```











**Запрос 2. Вывести альбомы, выпущенные после 1970 года.**





SQL













```

SELECT title, release_year

FROM album

WHERE release_year > 1970;



```











### 1.7. Выборка данных с логическими операциями





**Запрос 1. Найти песни длительностью от трёх до пяти минут включительно.**





SQL













```

SELECT title, duration_sec

FROM song

WHERE duration_sec >= 180

 AND duration_sec <= 300;



```











**Запрос 2. Вывести альбомы, выпущенные до 1980 года, кроме альбомов 1970 года.**





SQL













```

SELECT title, release_year

FROM album

WHERE release_year < 1980

 AND NOT (release_year = 1970);



```











### 1.8. Выборка данных с операторами `BETWEEN` и `IN`





**BETWEEN, запрос 1. Вывести песни длительностью от 180 до 300 секунд включительно.**





SQL













```

SELECT title, duration_sec

FROM song

WHERE duration_sec BETWEEN 180 AND 300;



```











**BETWEEN, запрос 2. Вывести альбомы, выпущенные в период с 1970 по 1980 год включительно.**





SQL













```

SELECT title, release_year

FROM album

WHERE release_year BETWEEN 1970 AND 1980;



```











**IN, запрос 1. Вывести альбомы, выпущенные в 1969, 1973 или 1991 году.**





SQL













```

SELECT title, release_year

FROM album

WHERE release_year IN (1969, 1973, 1991);



```











**IN, запрос 2. Вывести песни с номерами 1, 2 или 3 в альбоме.**





SQL













```

SELECT title, track_number

FROM song

WHERE track_number IN (1, 2, 3);



```











### 1.9. Выборка данных с сортировкой





**Запрос 1. Вывести песни в порядке убывания длительности, а при одинаковой длительности — по названию.**





SQL













```

SELECT title, duration_sec

FROM song

ORDER BY duration_sec DESC, title ASC;



```











**Запрос 2. Вывести альбомы от самых новых к самым старым.**





SQL













```

SELECT title, release_year

FROM album

ORDER BY release_year DESC, album_id ASC;



```











### 1.10. Выборка данных с оператором `LIKE`





**Запрос 1. Найти песни, названия которых начинаются с буквы «S».**





SQL













```

SELECT title

FROM song

WHERE title LIKE 'S%';



```











**Запрос 2. Найти имена исполнителей, содержащие последовательность «a».**





SQL













```

SELECT name

FROM artist

WHERE name LIKE '%a%';



```











### 1.11. Выбор уникальных значений столбца





**Запрос 1. Вывести уникальные годы выпуска альбомов.**





SQL













```

SELECT DISTINCT release_year

FROM album

ORDER BY release_year;



```











**Запрос 2. Вывести уникальные номера песен внутри альбомов.**





SQL













```

SELECT DISTINCT track_number

FROM song

ORDER BY track_number;



```











### 1.12. Выбор ограниченного количества строк





**Запрос 1. Показать три самых длинных песни.**





SQL













```

SELECT title, duration_sec

FROM song

ORDER BY duration_sec DESC, song_id ASC

LIMIT 3;



```











**Запрос 2. Пропустить самый старый альбом и вывести следующие два по году выпуска.**





SQL













```

SELECT title, release_year

FROM album

ORDER BY release_year ASC, album_id ASC

LIMIT 2 OFFSET 1;



```











### 1.13. Выборка данных с оператором `CASE`





**Запрос 1. Разделить песни на категории по длительности.**





SQL













```

SELECT title,

      duration_sec,

    CASE

       WHEN duration_sec < 180 THEN 'Короткая'

      WHEN duration_sec <= 300 THEN 'Средняя'

        ELSE 'Длинная'

     END AS duration_category

FROM song

ORDER BY duration_sec;



```











**Запрос 2. Разделить альбомы на периоды по году выпуска.**





SQL













```

SELECT title,

    release_year,

      CASE

          WHEN release_year < 1970 THEN 'До 1970 года'

          WHEN release_year < 1980 THEN '1970-е годы'

          ELSE '1980 год и позже'

      END AS release_period

FROM album

ORDER BY release_year;



```











## 2. JOIN





### 2.1. Внутреннее соединение `INNER JOIN`





**Запрос 1. Вывести названия альбомов и имена их исполнителей.**





SQL













```

SELECT a.title AS album_title,

      ar.name AS artist_name,

      a.release_year

FROM album AS a

INNER JOIN artist AS ar ON ar.artist_id = a.artist_id

ORDER BY a.album_id;



```











**Запрос 2. Вывести названия песен и альбомов, в которые они входят.**





SQL













```

SELECT s.title AS song_title,

      a.title AS album_title,

    s.track_number

FROM song AS s

INNER JOIN album AS a ON a.album_id = s.album_id

ORDER BY a.album_id, s.track_number;



```











### 2.2. Внешнее соединение `LEFT JOIN`





**Запрос 1. Вывести всех исполнителей и их альбомы. Для исполнителей без альбомов в столбцах альбома будет `NULL`.**





SQL













```

SELECT ar.name AS artist_name,

      a.title AS album_title

FROM artist AS ar

LEFT JOIN album AS a ON a.artist_id = ar.artist_id

ORDER BY ar.artist_id, a.album_id;



```











**Запрос 2. Вывести все альбомы и их песни. Альбомы без песен также попадут в результат.**





SQL













```

SELECT a.title AS album_title,

&#x20;      s.title AS song_title,

&#x20;      s.track_number

FROM album AS a

LEFT JOIN song AS s ON s.album_id = a.album_id

ORDER BY a.album_id, s.track_number;



```











### 2.3. Внешнее соединение `RIGHT JOIN`





**Запрос 1. Вывести все альбомы и имена их исполнителей.**





SQL













```

SELECT ar.name AS artist_name,

      a.title AS album_title

FROM artist AS ar

RIGHT JOIN album AS a ON a.artist_id = ar.artist_id

ORDER BY a.album_id;



```











**Запрос 2. Вывести все песни и названия их альбомов.**





SQL













```

SELECT a.title AS album_title,

&#x20;      s.title AS song_title,

&#x20;      s.track_number

FROM album AS a

RIGHT JOIN song AS s ON s.album_id = a.album_id

ORDER BY s.song_id;



```











### 2.4. Перекрёстное соединение `CROSS JOIN`





**Запрос 1. Получить все возможные пары «исполнитель — жанр».**





SQL













```

SELECT ar.name AS artist_name,

&#x20;      g.name AS genre_name

FROM artist AS ar

CROSS JOIN genre AS g

ORDER BY ar.artist_id, g.genre_id;



```











**Запрос 2. Получить все возможные пары «альбом — жанр».**





SQL













```

SELECT a.title AS album_title,

&#x20;      g.name AS genre_name

FROM album AS a

CROSS JOIN genre AS g

ORDER BY a.album_id, g.genre_id;



```











### 2.5. Полное внешнее соединение `FULL OUTER JOIN`





**Запрос 1. Вывести все песни и все жанры. Если у песни нет жанра или жанр ещё не назначен песне, соответствующие поля будут содержать `NULL`.**





SQL













```

SELECT s.title AS song_title,

      g.name AS genre_name

FROM song AS s

FULL OUTER JOIN song_genre AS sg ON sg.song_id = s.song_id

FULL OUTER JOIN genre AS g ON g.genre_id = sg.genre_id

ORDER BY s.song_id NULLS LAST, g.genre_id NULLS LAST;



```











**Запрос 2. Вывести все песни и все записи о назначенных жанрах, включая записи таблицы связи.**





SQL













```

SELECT s.song_id,

      s.title AS song_title,

      sg.genre_id

FROM song AS s

FULL OUTER JOIN song_genre AS sg ON sg.song_id = s.song_id

ORDER BY s.song_id NULLS LAST, sg.genre_id NULLS LAST;



```











### 2.6. Запросы на выборку из нескольких таблиц





**Запрос 1. Вывести исполнителей, их альбомы и песни из этих альбомов.**





SQL













```

SELECT ar.name AS artist_name,

      a.title AS album_title,

      s.title AS song_title,

    s.track_number

FROM artist AS ar

INNER JOIN album AS a ON a.artist_id = ar.artist_id

LEFT JOIN song AS s ON s.album_id = a.album_id

ORDER BY ar.artist_id, a.album_id, s.track_number;



```











**Запрос 2. Вывести названия песен и соответствующие им жанры. Песни без жанра тоже будут включены в результат.**





SQL













```

SELECT s.title AS song_title,

     g.name AS genre_name

FROM song AS s

LEFT JOIN song_genre AS sg ON sg.song_id = s.song_id

LEFT JOIN genre AS g ON g.genre_id = sg.genre_id

ORDER BY s.song_id, g.genre_id;

```

