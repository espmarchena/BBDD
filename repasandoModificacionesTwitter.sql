-- 1. Dame los nombres de los usuarios ordenados alfabéticamente con su nick y su email.  -
select
	nombre,
	nick,
	email
from usuarios
order by nombre asc;
	

-- 2. Dame el nombre del usuario con más seguidores. *SUM->suma, COUNT->cuenta* -
select
	u.nombre,
	u.nick,
	count(*) AS totalSeguidores
from
	usuarios u 
join
	seguidores s on u.id = s.idseguido
group by
	u.id
order by
	totalSeguidores desc
limit 1;


-- 3. Dame la fecha y el texto del tweet con más likes.  -
select
	t.fecha,
	t.texto,
	count(*) as totalLikes
from
	tweets t
join
	likes l on t.id = l.idtweet
group by
	t.id
order by
	totalLikes desc
limit 1;


-- 4. ¿Hay alguna contraseña duplicada?, localízalas.  
select
	u.contrasena,
	count(*) as totalVeces
from
	usuarios u
group by
	u.contrasena 
having
	totalVeces >1;


-- 5. Dame la lista de los 5 usuarios (nombre, nick y email) con más tweets publicados.  -
select
	u.nombre,
	u.nick,
	u.email,
	count (*) as totalTweets
from
	usuarios u
join
	tweets t on u.id = t.idusuario
group by
	u.id
order by
	totaltweets desc
limit 5;


-- 6. ¿Hay algún usuario que nunca haya publicado un tweet? localízalos.  
select
	u.nombre,
	u.nick
from
	usuarios u
left join
	tweets t on u.id = t.idusuario
where
	t.id is null;


-- 7. Si en este twitter cada usuario cobra 2 céntimos de euro por cada like recibido en un tweet suyo,
-- calcula cuánto ha cobrado el usuario con el nick juanlopez en 2024.  -
select
	u.nick,
	count(*) * 0.02 AS totalEuros
from
	usuarios u
join
	tweets t on u.id = t.idusuario
join 
	likes l on t.id = l.idtweet
where
	u.nick = 'juanlopez' and year(l.fecha_like) = 2024;


-- 8. Saca la lista de usuarios con más de 3 tweets.  -
select
	u.nombre,
	u.nick,
	count(*) as totalTweets
from
	usuarios u
join
	tweets t on u.id = t.idusuario
group by
	u.id
having
	totalTweets > 3;


-- 9. ¿En qué mes se han publicado más tweets durante el año 2024? -
select
	month(fecha) as mes,
	count(*) as totalTweets
from
	tweets t
where
	year(fecha) = 2024
group by
	mes
order by
	totalTweets desc
limit 1;


-- 10. ¿Qué usuario ha dado más likes en total? -
select
	u.nombre,
	u.nick,
	count(*) as totalLikes
from
	usuarios u
join
	tweets t on u.id = t.idusuario
group by
	u.id
order by
	totalLikes desc
limit 1;


-- 11. Consulta extra. Calcula el promedio de likes por tweet. 
select
	round(count(l.idtweet) / count(distinct t.id), 2) as promedioLikesPorTweet
from
	tweets t
left join
	likes l on t.id = l.idtweet;

