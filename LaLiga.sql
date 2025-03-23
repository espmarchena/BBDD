create database LaLiga;
use LaLiga;

-- 1. Obtén la plantilla (nombre de los jugadores) del Betis o Sevilla
select j.nombre, e.nombre
from jugadores j
join equipos e on j.idEquipoActual = e.idEquipo
where e.nombre like '%Betis%' or e.nombre like '%Fc Sevilla%';

-- 2. ¿Hay algún jugador o jugadores que cumplan años hoy? ¿quien?
select j.nombre, j.fechanacimiento
from jugadores j
where month(j.fechanacimiento) = month(curdate()) and day(j.fechanacimiento) = day(curdate());

-- 3. Listar los resultados de todos los derbis Sevillanos (Partidos Betis-Sevilla). Debéis darme el nombre del equipo local, el equipo visitante y el marcador y la fecha.
-- Ejemplo:
-- 2022-01-16 00:00:00.000
-- Real Betis Sevilla 2
-- Fc Sevilla
-- 2021-11-07 00:00:00.000
-- Real Betis Sevilla 0
-- Fc Sevilla
select distinct p.fecha, e.nombre, p.GolesLocales, p.fecha, eq.nombre, p.GolesVisitantes
from partidos p
join partidosjugadores pj on p.idPartido = pj.idpartido
join equipos e on e.idEquipo = p.idEquipoLocal 
join equipos eq on eq.idEquipo = p.idEquipoVisitante
where e.nombre like '%Betis%' and eq.nombre like '%Fc Sevilla%';
-- ¿Sabrías calcular cuantos derbis han acabado en empate? (puntos extra)
select count(*) as derbis_empatados
from partidos p
join equipos e on p.idEquipoLocal = e.idEquipo
join equipos eq on p.idEquipoVisitante = eq.idEquipo
where ((e.nombre like '%Betis%' and eq.nombre like '%Fc sevilla%')
   or (e.nombre like '%Fc sevilla%' and eq.nombre like '%Betis%'))
   and p.GolesLocales = p.GolesVisitantes;

-- 4. Dame los 20 partidos con más goles. De cada partido debes darme el nombre del equipo local, el equipo visitante y el marcador y la fecha del encuentro.
select p.fecha, e.nombre, eq.nombre, p.goleslocales, p.golesvisitantes
from partidos p
join equipos e on p.idequipolocal = e.idequipo
join equipos eq on p.idequipovisitante = eq.idequipo
order by (p.goleslocales + p.golesvisitantes) desc
limit 20;

-- 5. ¿Cuántos jugadores han cambiado de nacionalidad? (país es distinto del país nacionalidad)


-- 6. Dime los 10 jugadores de laliga con más tarjetas amarillas (nombre y num de tarjetas).


-- 7. Calcula el año de nacimiento medio de cada equipo de laliga española en la temporada 2021. (pista: usad la función AVG y la función YEAR)


-- 8. Dime el jugador más viejo de la bbdd. Del jugador quiero saber su nombre, su fecha de nacimiento, el país, y el nombre del equipo en el que juega.


-- 9. Saca una tabla con el nombre de la competición, país de la competición, la temporada y el número de partidos disputados en cada competición y temporada (Pista: usad COUNT())

