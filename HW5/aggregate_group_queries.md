## a. Агрегатные функции

### COUNT()

**Запрос 1.** Подсчитать общее количество песен.

```sql
SELECT COUNT(*) AS songs_count
FROM song;
```

**Запрос 2.** Подсчитать количество уникальных песен в каждом жанре.

```sql
SELECT g.name AS genre_name,
       COUNT(DISTINCT sg.song_id) AS songs_count
FROM genre AS g
LEFT JOIN song_genre AS sg ON sg.genre_id = g.genre_id
GROUP BY g.genre_id, g.name
ORDER BY g.name;
```

### SUM()

**Запрос 1.** Подсчитать общую длительность всех песен в секундах.

```sql
SELECT SUM(duration_sec) AS total_duration_sec
FROM song;
```

**Запрос 2.** Подсчитать общую длительность песен каждого альбома.

```sql
SELECT a.title AS album_title,
       SUM(s.duration_sec) AS total_duration_sec
FROM album AS a
JOIN song AS s ON s.album_id = a.album_id
GROUP BY a.album_id, a.title
ORDER BY a.title;
```

### AVG()

**Запрос 1.** Найти среднюю длительность песни.

```sql
SELECT ROUND(AVG(duration_sec), 2) AS average_duration_sec
FROM song;
```

**Запрос 2.** Найти средний год выпуска альбомов каждого исполнителя.

```sql
SELECT ar.name AS artist_name,
       ROUND(AVG(a.release_year), 2) AS average_release_year
FROM artist AS ar
JOIN album AS a ON a.artist_id = ar.artist_id
GROUP BY ar.artist_id, ar.name
ORDER BY ar.name;
```

### MIN()

**Запрос 1.** Найти длительность самой короткой песни.

```sql
SELECT MIN(duration_sec) AS shortest_song_sec
FROM song;
```

**Запрос 2.** Найти год выпуска самого старого альбома.

```sql
SELECT MIN(release_year) AS earliest_release_year
FROM album;
```

### MAX()

**Запрос 1.** Найти длительность самой длинной песни.

```sql
SELECT MAX(duration_sec) AS longest_song_sec
FROM song;
```

**Запрос 2.** Найти год выпуска самого нового альбома.

```sql
SELECT MAX(release_year) AS latest_release_year
FROM album;
```

### STRING_AGG()

**Запрос 1.** Объединить имена всех исполнителей в одну строку в алфавитном порядке.

```sql
SELECT STRING_AGG(name, ', ' ORDER BY name) AS artist_names
FROM artist;
```

**Запрос 2.** Вывести для каждого альбома список песен, упорядоченный по номеру композиции.

```sql
SELECT a.title AS album_title,
       STRING_AGG(s.title, ', ' ORDER BY s.track_number) AS song_list
FROM album AS a
JOIN song AS s ON s.album_id = a.album_id
GROUP BY a.album_id, a.title
ORDER BY a.title;
```

## b. GROUP BY, HAVING

### GROUP BY

**Запрос 1.** Подсчитать количество альбомов каждого исполнителя, включая исполнителей без альбомов.

```sql
SELECT ar.artist_id,
       ar.name AS artist_name,
       COUNT(a.album_id) AS albums_count
FROM artist AS ar
LEFT JOIN album AS a ON a.artist_id = ar.artist_id
GROUP BY ar.artist_id, ar.name
ORDER BY ar.name;
```

**Запрос 2.** Подсчитать количество песен в каждом альбоме.

```sql
SELECT a.album_id,
       a.title AS album_title,
       COUNT(s.song_id) AS songs_count
FROM album AS a
LEFT JOIN song AS s ON s.album_id = a.album_id
GROUP BY a.album_id, a.title
ORDER BY a.title;
```

### HAVING

**Запрос 1.** Вывести исполнителей, у которых выпущено больше одного альбома.

```sql
SELECT ar.name AS artist_name,
       COUNT(a.album_id) AS albums_count
FROM artist AS ar
JOIN album AS a ON a.artist_id = ar.artist_id
GROUP BY ar.artist_id, ar.name
HAVING COUNT(a.album_id) > 1
ORDER BY albums_count DESC, artist_name;
```

**Запрос 2.** Вывести жанры, к которым относятся не менее пяти песен.

```sql
SELECT g.name AS genre_name,
       COUNT(DISTINCT sg.song_id) AS songs_count
FROM genre AS g
JOIN song_genre AS sg ON sg.genre_id = g.genre_id
GROUP BY g.genre_id, g.name
HAVING COUNT(DISTINCT sg.song_id) >= 5
ORDER BY songs_count DESC, genre_name;
```

## c. GROUPING SETS, ROLLUP и CUBE

### GROUPING SETS

**Запрос 1.** Подсчитать количество песен отдельно по исполнителям, отдельно по альбомам и общее количество.

```sql
SELECT ar.name AS artist_name,
       a.title AS album_title,
       COUNT(s.song_id) AS songs_count
FROM artist AS ar
JOIN album AS a ON a.artist_id = ar.artist_id
JOIN song AS s ON s.album_id = a.album_id
GROUP BY GROUPING SETS (
    (ar.name),
    (a.title),
    ()
)
ORDER BY artist_name NULLS LAST, album_title NULLS LAST;
```

**Запрос 2.** Подсчитать количество песен отдельно по жанрам и годам выпуска альбомов, а также получить общий итог.

```sql
SELECT g.name AS genre_name,
       a.release_year,
       COUNT(DISTINCT s.song_id) AS songs_count
FROM song AS s
JOIN album AS a ON a.album_id = s.album_id
JOIN song_genre AS sg ON sg.song_id = s.song_id
JOIN genre AS g ON g.genre_id = sg.genre_id
GROUP BY GROUPING SETS (
    (g.name),
    (a.release_year),
    ()
)
ORDER BY genre_name NULLS LAST, a.release_year NULLS LAST;
```

### ROLLUP

**Запрос 1.** Подсчитать песни по каждому альбому, итоги по исполнителям и общий итог.

```sql
SELECT ar.name AS artist_name,
       a.title AS album_title,
       COUNT(s.song_id) AS songs_count
FROM artist AS ar
JOIN album AS a ON a.artist_id = ar.artist_id
LEFT JOIN song AS s ON s.album_id = a.album_id
GROUP BY ROLLUP (ar.name, a.title)
ORDER BY artist_name NULLS LAST, album_title NULLS LAST;
```

**Запрос 2.** Подсчитать количество песен по каждому жанру и году выпуска альбома, с промежуточными и общим итогами.

```sql
SELECT g.name AS genre_name,
       a.release_year,
       COUNT(DISTINCT s.song_id) AS songs_count
FROM song AS s
JOIN album AS a ON a.album_id = s.album_id
JOIN song_genre AS sg ON sg.song_id = s.song_id
JOIN genre AS g ON g.genre_id = sg.genre_id
GROUP BY ROLLUP (g.name, a.release_year)
ORDER BY genre_name NULLS LAST, a.release_year NULLS LAST;
```

### CUBE

**Запрос 1.** Подсчитать песни для всех сочетаний исполнителей и жанров, включая промежуточные и общий итоги.

```sql
SELECT ar.name AS artist_name,
       g.name AS genre_name,
       COUNT(DISTINCT s.song_id) AS songs_count
FROM artist AS ar
JOIN album AS a ON a.artist_id = ar.artist_id
JOIN song AS s ON s.album_id = a.album_id
JOIN song_genre AS sg ON sg.song_id = s.song_id
JOIN genre AS g ON g.genre_id = sg.genre_id
GROUP BY CUBE (ar.name, g.name)
ORDER BY artist_name NULLS LAST, genre_name NULLS LAST;
```

**Запрос 2.** Подсчитать количество песен для всех сочетаний года выпуска альбома и жанра, включая промежуточные и общий итоги.

```sql
SELECT a.release_year,
       g.name AS genre_name,
       COUNT(DISTINCT s.song_id) AS songs_count
FROM album AS a
JOIN song AS s ON s.album_id = a.album_id
JOIN song_genre AS sg ON sg.song_id = s.song_id
JOIN genre AS g ON g.genre_id = sg.genre_id
GROUP BY CUBE (a.release_year, g.name)
ORDER BY a.release_year NULLS LAST, genre_name NULLS LAST;
```

## d. SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY

**Запрос 1.** Вывести исполнителей, выпустивших после 1970 года не менее двух альбомов. Отсортировать по количеству таких альбомов.

```sql
SELECT ar.name AS artist_name,
       COUNT(a.album_id) AS albums_count
FROM artist AS ar
JOIN album AS a ON a.artist_id = ar.artist_id
WHERE a.release_year > 1970
GROUP BY ar.artist_id, ar.name
HAVING COUNT(a.album_id) >= 2
ORDER BY albums_count DESC, artist_name;
```

**Запрос 2.** Вывести жанры, в которых есть не менее трёх песен длительностью более 180 секунд. Показать количество и среднюю длительность таких песен.

```sql
SELECT g.name AS genre_name,
       COUNT(DISTINCT s.song_id) AS songs_count,
       ROUND(AVG(s.duration_sec), 2) AS average_duration_sec
FROM genre AS g
JOIN song_genre AS sg ON sg.genre_id = g.genre_id
JOIN song AS s ON s.song_id = sg.song_id
WHERE s.duration_sec > 180
GROUP BY g.genre_id, g.name
HAVING COUNT(DISTINCT s.song_id) >= 3
ORDER BY songs_count DESC, genre_name;
```
