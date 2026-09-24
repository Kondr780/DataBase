DROP TABLE IF EXISTS song;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS artist;

CREATE TABLE artist(
	artist_id SERIAL PRIMARY KEY,
	name VARCHAR(50),
	country VARCHAR(50),
	formed_year INT CHECK(formed_year >= 1000 and formed_year <= 2026)
);

CREATE TABLE album(
	album_id SERIAL PRIMARY KEY,
	title VARCHAR(50),
	release_year INT CHECK(release_year >= 1000 and release_year <= 2026),
	artist_id INT REFERENCES artist(artist_id) 
);

CREATE TABLE track(
	track_id SERIAL PRIMARY KEY,
	title VARCHAR(50),
	duration_sec INT CHECK(duration_sec >= 0),
	track_number INT CHECK(track_number > 0),
	album_id INT REFERENCES album(album_id)
);

ALTER TABLE artist DROP COLUMN country;
ALTER TABLE track RENAME TO song;
ALTER TABLE song ALTER COLUMN title TYPE TEXT;

INSERT INTO artist (name, formed_year) VALUES
	('The Beatles', 1960),
	('Queen', 1970),
	('Pink Floyd', 1965),
	('Nirvana', 1987),
	('Radiohead', 1985);

INSERT INTO album (title, release_year, artist_id) VALUES
	('Abbey Road', 1969, 1),
	('Let It Be', 1970, 1),
	('A Night at the Opera', 1975, 2),
	('The Dark Side of the Moon', 1973, 3),
	('Wish You Were Here', 1975, 3),
	('Nevermind', 1991, 4),
	('OK Computer', 1997, 5);

INSERT INTO song (title, duration_sec, track_number, album_id) VALUES
	('Come Together', 259, 1, 1),
	('Something', 182, 2, 1),
	('Here Comes the Sun', 185, 3, 1),
	('Let It Be', 243, 1, 2),
	('Get Back', 190, 2, 2),
	('Bohemian Rhapsody', 354, 1, 3),
	('Love of My Life', 219, 2, 3),
	('You''re My Best Friend', 172, 3, 3),
	('Speak to Me', 68, 1, 4),
	('Breathe', 169, 2, 4),
	('Time', 413, 3, 4),
	('Money', 382, 4, 4),
	('Shine On You Crazy Diamond', 810, 1, 5),
	('Wish You Were Here', 334, 2, 5),
	('Smells Like Teen Spirit', 301, 1, 6),
	('Come as You Are', 218, 2, 6),
	('Lithium', 253, 3, 6),
	('Airbag', 284, 1, 7),
	('Paranoid Android', 383, 2, 7),
	('Karma Police', 264, 3, 7),
	('No Surprises', 229, 4, 7);

UPDATE artist
SET formed_year = 1962
WHERE name = 'The Beatles';

UPDATE song
SET duration_sec = 265
WHERE title = 'Come Together';

UPDATE album
SET release_year = 1976
WHERE title = 'A Night at the Opera';

UPDATE song
SET title = 'Come Together (Remastered)',
    duration_sec = 270
WHERE title = 'Come Together';

SELECT * FROM song;