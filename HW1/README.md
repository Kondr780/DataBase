# Запрос 1

Найти названия фильмов, выпущенных после 2010 года, длительностью более 120 минут.

π title(σ release\_year>2010 ∧ duration\_min>120 (MOVIE))


# Запрос 2


Получить список названий фильмов вместе с именами их режиссёров.

π title,name(MOVIE⋈MOVIE.director\_id=DIRECTOR.director\_id DIRECTOR)



