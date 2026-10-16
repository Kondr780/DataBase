## 1. SELECT





### 1.1. Выборка всех данных из таблицы





**Запрос 1. Вывести всю информацию о песнях.\*\*





SQL













```

SELECT *

FROM song;



```











**Запрос 2. Вывести всю информацию об альбомах.\*\*





SQL













```

SELECT *

FROM album;



```











### 1.2. Выборка отдельных столбцов





**Запрос 1. Вывести названия песен и их длительность в секундах.\*\*





SQL













```

SELECT title, duration\_sec

FROM song;



```











\*\*Запрос 2. Вывести имена исполнителей и годы их основания.\*\*





SQL













```

SELECT name, formed\_year

FROM artist;



```











\### 1.3. Присвоение новых имён столбцам при формировании выборки





\*\*Запрос 1. Вывести названия альбомов и годы выпуска под новыми именами столбцов.\*\*





SQL













```

SELECT title AS album\_title,

&#x20;      release\_year AS year\_released

FROM album;



```











\*\*Запрос 2. Вывести названия песен и их номера в альбоме.\*\*





SQL













```

SELECT title AS song\_title,

&#x20;      track\_number AS song\_number

FROM song;



```











\### 1.4. Выборка данных с созданием вычисляемого столбца





\*\*Запрос 1. Вывести длительность песен также в минутах.\*\*





SQL













```

SELECT title,

&#x20;      duration\_sec,

&#x20;      duration\_sec / 60.0 AS duration\_min

FROM song;



```











\*\*Запрос 2. Для каждого исполнителя рассчитать, сколько лет прошло с года его основания до 2026 года.\*\*





SQL













```

SELECT name,

&#x20;      formed\_year,

&#x20;      2026 - formed\_year AS years\_since\_formed

FROM artist;



```











\### 1.5. Выборка данных, вычисляемые столбцы и математические функции





\*\*Запрос 1. Вывести длительность песен в минутах, округлив её до двух знаков после запятой.\*\*





SQL













```

SELECT title,

&#x20;      duration\_sec,

&#x20;      ROUND(duration\_sec / 60.0, 2) AS duration\_min

FROM song;



```











\*\*Запрос 2. Вывести разницу между годом выпуска альбома и 1970 годом.\*\*





SQL













```

SELECT title,

&#x20;      release\_year,

&#x20;      ABS(release\_year - 1970) AS years\_from\_1970

FROM album;



```











\### 1.6. Выборка данных по условию





\*\*Запрос 1. Найти песни длительностью более пяти минут.\*\*





SQL













```

SELECT title, duration\_sec

FROM song

WHERE duration\_sec > 300;



```











\*\*Запрос 2. Вывести альбомы, выпущенные после 1970 года.\*\*





SQL













```

SELECT title, release\_year

FROM album

WHERE release\_year > 1970;



```











\### 1.7. Выборка данных с логическими операциями





\*\*Запрос 1. Найти песни длительностью от трёх до пяти минут включительно.\*\*





SQL













```

SELECT title, duration\_sec

FROM song

WHERE duration\_sec >= 180

&#x20; AND duration\_sec <= 300;



```











\*\*Запрос 2. Вывести альбомы, выпущенные до 1980 года, кроме альбомов 1970 года.\*\*





SQL













```

SELECT title, release\_year

FROM album

WHERE release\_year < 1980

&#x20; AND NOT (release\_year = 1970);



```











\### 1.8. Выборка данных с операторами `BETWEEN` и `IN`





\*\*BETWEEN, запрос 1. Вывести песни длительностью от 180 до 300 секунд включительно.\*\*





SQL













```

SELECT title, duration\_sec

FROM song

WHERE duration\_sec BETWEEN 180 AND 300;



```











\*\*BETWEEN, запрос 2. Вывести альбомы, выпущенные в период с 1970 по 1980 год включительно.\*\*





SQL













```

SELECT title, release\_year

FROM album

WHERE release\_year BETWEEN 1970 AND 1980;



```











\*\*IN, запрос 1. Вывести альбомы, выпущенные в 1969, 1973 или 1991 году.\*\*





SQL













```

SELECT title, release\_year

FROM album

WHERE release\_year IN (1969, 1973, 1991);



```











\*\*IN, запрос 2. Вывести песни с номерами 1, 2 или 3 в альбоме.\*\*





SQL













```

SELECT title, track\_number

FROM song

WHERE track\_number IN (1, 2, 3);



```











\### 1.9. Выборка данных с сортировкой





\*\*Запрос 1. Вывести песни в порядке убывания длительности, а при одинаковой длительности — по названию.\*\*





SQL













```

SELECT title, duration\_sec

FROM song

ORDER BY duration\_sec DESC, title ASC;



```











\*\*Запрос 2. Вывести альбомы от самых новых к самым старым.\*\*





SQL













```

SELECT title, release\_year

FROM album

ORDER BY release\_year DESC, album\_id ASC;



```











\### 1.10. Выборка данных с оператором `LIKE`





\*\*Запрос 1. Найти песни, названия которых начинаются с буквы «S».\*\*





SQL













```

SELECT title

FROM song

WHERE title LIKE 'S%';



```











\*\*Запрос 2. Найти имена исполнителей, содержащие последовательность «a».\*\*





SQL













```

SELECT name

FROM artist

WHERE name LIKE '%a%';



```











\### 1.11. Выбор уникальных значений столбца





\*\*Запрос 1. Вывести уникальные годы выпуска альбомов.\*\*





SQL













```

SELECT DISTINCT release\_year

FROM album

ORDER BY release\_year;



```











\*\*Запрос 2. Вывести уникальные номера песен внутри альбомов.\*\*





SQL













```

SELECT DISTINCT track\_number

FROM song

ORDER BY track\_number;



```











\### 1.12. Выбор ограниченного количества строк





\*\*Запрос 1. Показать три самых длинных песни.\*\*





SQL













```

SELECT title, duration\_sec

FROM song

ORDER BY duration\_sec DESC, song\_id ASC

LIMIT 3;



```











\*\*Запрос 2. Пропустить самый старый альбом и вывести следующие два по году выпуска.\*\*





SQL













```

SELECT title, release\_year

FROM album

ORDER BY release\_year ASC, album\_id ASC

LIMIT 2 OFFSET 1;



```











\### 1.13. Выборка данных с оператором `CASE`





\*\*Запрос 1. Разделить песни на категории по длительности.\*\*





SQL













```

SELECT title,

&#x20;      duration\_sec,

&#x20;      CASE

&#x20;          WHEN duration\_sec < 180 THEN 'Короткая'

&#x20;          WHEN duration\_sec <= 300 THEN 'Средняя'

&#x20;          ELSE 'Длинная'

&#x20;      END AS duration\_category

FROM song

ORDER BY duration\_sec;



```











\*\*Запрос 2. Разделить альбомы на периоды по году выпуска.\*\*





SQL













```

SELECT title,

&#x20;      release\_year,

&#x20;      CASE

&#x20;          WHEN release\_year < 1970 THEN 'До 1970 года'

&#x20;          WHEN release\_year < 1980 THEN '1970-е годы'

&#x20;          ELSE '1980 год и позже'

&#x20;      END AS release\_period

FROM album

ORDER BY release\_year;



```











\## 2. JOIN





\### 2.1. Внутреннее соединение `INNER JOIN`





\*\*Запрос 1. Вывести названия альбомов и имена их исполнителей.\*\*





SQL













```

SELECT a.title AS album\_title,

&#x20;      ar.name AS artist\_name,

&#x20;      a.release\_year

FROM album AS a

INNER JOIN artist AS ar ON ar.artist\_id = a.artist\_id

ORDER BY a.album\_id;



```











\*\*Запрос 2. Вывести названия песен и альбомов, в которые они входят.\*\*





SQL













```

SELECT s.title AS song\_title,

&#x20;      a.title AS album\_title,

&#x20;      s.track\_number

FROM song AS s

INNER JOIN album AS a ON a.album\_id = s.album\_id

ORDER BY a.album\_id, s.track\_number;



```











\### 2.2. Внешнее соединение `LEFT JOIN`





\*\*Запрос 1. Вывести всех исполнителей и их альбомы. Для исполнителей без альбомов в столбцах альбома будет `NULL`.\*\*





SQL













```

SELECT ar.name AS artist\_name,

&#x20;      a.title AS album\_title

FROM artist AS ar

LEFT JOIN album AS a ON a.artist\_id = ar.artist\_id

ORDER BY ar.artist\_id, a.album\_id;



```











\*\*Запрос 2. Вывести все альбомы и их песни. Альбомы без песен также попадут в результат.\*\*





SQL













```

SELECT a.title AS album\_title,

&#x20;      s.title AS song\_title,

&#x20;      s.track\_number

FROM album AS a

LEFT JOIN song AS s ON s.album\_id = a.album\_id

ORDER BY a.album\_id, s.track\_number;



```











\### 2.3. Внешнее соединение `RIGHT JOIN`





\*\*Запрос 1. Вывести все альбомы и имена их исполнителей.\*\*





SQL













```

SELECT ar.name AS artist\_name,

&#x20;      a.title AS album\_title

FROM artist AS ar

RIGHT JOIN album AS a ON a.artist\_id = ar.artist\_id

ORDER BY a.album\_id;



```











\*\*Запрос 2. Вывести все песни и названия их альбомов.\*\*





SQL













```

SELECT a.title AS album\_title,

&#x20;      s.title AS song\_title,

&#x20;      s.track\_number

FROM album AS a

RIGHT JOIN song AS s ON s.album\_id = a.album\_id

ORDER BY s.song\_id;



```











\### 2.4. Перекрёстное соединение `CROSS JOIN`





\*\*Запрос 1. Получить все возможные пары «исполнитель — жанр».\*\*





SQL













```

SELECT ar.name AS artist\_name,

&#x20;      g.name AS genre\_name

FROM artist AS ar

CROSS JOIN genre AS g

ORDER BY ar.artist\_id, g.genre\_id;



```











\*\*Запрос 2. Получить все возможные пары «альбом — жанр».\*\*





SQL













```

SELECT a.title AS album\_title,

&#x20;      g.name AS genre\_name

FROM album AS a

CROSS JOIN genre AS g

ORDER BY a.album\_id, g.genre\_id;



```











\### 2.5. Полное внешнее соединение `FULL OUTER JOIN`





\*\*Запрос 1. Вывести все песни и все жанры. Если у песни нет жанра или жанр ещё не назначен песне, соответствующие поля будут содержать `NULL`.\*\*





SQL













```

SELECT s.title AS song\_title,

&#x20;      g.name AS genre\_name

FROM song AS s

FULL OUTER JOIN song\_genre AS sg ON sg.song\_id = s.song\_id

FULL OUTER JOIN genre AS g ON g.genre\_id = sg.genre\_id

ORDER BY s.song\_id NULLS LAST, g.genre\_id NULLS LAST;



```











\*\*Запрос 2. Вывести все песни и все записи о назначенных жанрах, включая записи таблицы связи.\*\*





SQL













```

SELECT s.song\_id,

&#x20;      s.title AS song\_title,

&#x20;      sg.genre\_id

FROM song AS s

FULL OUTER JOIN song\_genre AS sg ON sg.song\_id = s.song\_id

ORDER BY s.song\_id NULLS LAST, sg.genre\_id NULLS LAST;



```











\### 2.6. Запросы на выборку из нескольких таблиц





\*\*Запрос 1. Вывести исполнителей, их альбомы и песни из этих альбомов.\*\*





SQL













```

SELECT ar.name AS artist\_name,

&#x20;      a.title AS album\_title,

&#x20;      s.title AS song\_title,

&#x20;      s.track\_number

FROM artist AS ar

INNER JOIN album AS a ON a.artist\_id = ar.artist\_id

LEFT JOIN song AS s ON s.album\_id = a.album\_id

ORDER BY ar.artist\_id, a.album\_id, s.track\_number;



```











\*\*Запрос 2. Вывести названия песен и соответствующие им жанры. Песни без жанра тоже будут включены в результат.\*\*





SQL













```

SELECT s.title AS song\_title,

&#x20;      g.name AS genre\_name

FROM song AS s

LEFT JOIN song\_genre AS sg ON sg.song\_id = s.song\_id

LEFT JOIN genre AS g ON g.genre\_id = sg.genre\_id

ORDER BY s.song\_id, g.genre\_id;

```

