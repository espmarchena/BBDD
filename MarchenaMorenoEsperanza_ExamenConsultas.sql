use twitter;

-- 1. Dame los nombres de los usuarios ordenados alfabéticamente con su nick y su email.  -
select nombre, nick, email
from usuarios
order by nombre asc;

-- 2. Dame el nombre del usuario con más seguidores. *SUM->suma, COUNT->cuenta* -
select u.nombre, count(s.idseguidor) as cantidadseguidores
from usuarios u
join seguidores s on s.idseguidor = u.id;

-- 3. Dame la fecha y el texto del tweet con más likes.  -
select t.fecha as fechapublicacion, t.texto, count(l.fecha_like) as cantidadlikes
from tweets t
join likes l on l.idtweet = t.id
order by cantidadlikes;

-- 4. ¿Hay alguna contraseña duplicada?, localízalas.  
select u.contrasena
from usuarios u

-- 5. Dame la lista de los 5 usuarios (nombre, nick y email) con más tweets publicados.  -
select u.nombre, u.nick, u.email, t.texto
from usuarios u
join tweets t on t.id = u.id
group by t.id desc
limit 5;

-- 6. ¿Hay algún usuario que nunca haya publicado un tweet? localízalos.  
select u.nick 
from usuarios u
join tweets t on t.idusuario = u.id
where t.texto = null;

-- 7. Si en este twitter cada usuario cobra 2 céntimos de euro por cada like recibido en un tweet suyo, calcula cuánto ha cobrado el usuario con el nick juanlopez en 2024.  -
select u.nick, (count(t.texto))*0.02 as cobrotweets
from usuarios u
join tweets t on u.id = t.idusuario
where u.nick like '%juanlopez%'

-- 8. Saca la lista de usuarios con más de 3 tweets.  -
select u.nombre, t.texto
from usuarios u
join tweets t on t.idusuario = u.id
having count(t.texto) > 3;

-- 9. ¿En qué mes se han publicado más tweets durante el año 2024? -
select month(t.fecha) as mes, t.texto
from tweets t
where t.fecha like '%2024%'
group by mes desc limit 1;

-- 10. ¿Qué usuario ha dado más likes en total? -
select u.nick
from usuarios u
join likes l on l.idusuario = u.id
group by l.idusuario desc limit 1;

-- 11. Consulta extra. Calcula el promedio de likes por tweet. 

