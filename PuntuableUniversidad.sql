create database PuntuableUniversidad;
use PuntuableUniversidad;

-- Consultas sobre una tabla
 -- 1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos.
 -- El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
select apellido1, apellido2, nombre
from persona
where tipo = 'alumno'
order by apellido1, apellido2, nombre DESC;

 -- 2. Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
select nombre, apellido1, apellido2
from persona
where telefono is null and tipo = 'alumno';

 -- 3. Devuelve el listado de los alumnos que nacieron en 1999.
select apellido1, apellido2, nombre, year(1999)
from persona
where tipo = 'alumno';

 -- 4. Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.
select nif, nombre, apellido1, apellido2
from persona
where telefono is null and tipo = 'profesor' and substring (nif, 9, 1) = 'K';

 -- 5. Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
select nombre
from asignatura
where id_grado = 7 and curso = 3 and cuatrimestre = 1;

-- Consultas multitabla (Composición interna)
-- 1. Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).
select distinct p.*, g.nombre 
from persona p
join alumno_se_matricula_asignatura ama on p.id = ama.id_alumno
join asignatura a on ama.id_asignatura = a.id_grado
join grado g on g.id = a.id
where p.tipo = 'alumno' and p.sexo = 'M' and g.id = 4;

-- 2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).
select a.nombre
from asignatura a
join grado g on g.id = a.id_grado
where g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 3. Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados.
-- El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento.
-- El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.
 select p.nombre, p.apellido1, p.apellido2, d.nombre
 from persona p
 join profesor pr on p.id = pr.id_profesor
 join departamento d on d.id = pr.id_profesor
 order by p.apellido1, p.apellido2, p.nombre desc;

-- 4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 26902806M.
 select distinct a.nombre, ce.anyo_inicio, ce.anyo_fin
 from asignatura a
 join alumno_se_matricula_asignatura ama on ama.id_asignatura = a.id
 join curso_escolar ce on ce.id = a.id
 join persona p on p.id = ama.id_alumno
 where nif ='26902806M';

-- 5. Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
 select distinct d.nombre as nombre_departamento
 from departamento d
 join profesor pr on pr.id_departamento = d.id
 join asignatura a on a.id_profesor = pr.id_profesor
 join grado g on g.id = a.id
 where g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 6. Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.
select distinct p.nombre, p.apellido1, p.apellido2, ce.anyo_inicio
from persona p
join alumno_se_matricula_asignatura ama on ama.id_alumno = p.id
join curso_escolar ce on ama.id_curso_escolar = ce.id
where p.tipo = 'alumno' and ce.id = 5;

 -- Consultas multitabla (Composición externa)
 -- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
 -- 1. Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados.
 -- El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado.
 -- El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor.
 -- El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.


 -- 2. Devuelve un listado con los profesores que no están asociados a un departamento.


 -- 3. Devuelve un listado con los departamentos que no tienen profesores asociados.


 -- 4. Devuelve un listado con los profesores que no imparten ninguna asignatura.


 -- 5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.


 -- 6. Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar.
 -- El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca
 

 