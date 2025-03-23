use empresa;

-- Consultas SQL para Practicar 
-- 1. Listar el nombre de los departamentos al cual pertenece cada empleado. 
select e.nombre, d.nombre
from empleado e
join departamento d on e.cddep = d.cddep;

-- 2. Listar los proyectos a los que están asignados los empleados. 
select distinct p.nombre
from proyecto p
join trabaja t on p.cdpro = t.cdpro;

-- 3. Listar el nombre de los empleados y el número de horas que han trabajado en cada proyecto. 
select e.nombre, p.nombre, t.nhoras
from empleado e
join trabaja t on e.cdemp = t.cdemp
join proyecto p on t.cdpro = p.cdpro;

-- 4. Listar el nombre de los empleados que trabajan en el departamento de Desarrollo. 
select e.nombre
from empleado e
join departamento d on e.cddep = d.cddep
where d.nombre = 'Desarrollo de software';

-- 5. Listar el nombre de los proyectos en los que trabaja el empleado E01. 
select p.nombre
from proyecto p
join trabaja t on p.cdpro = t.cdpro
where t.cdemp = 'E01';

-- 6. Listar el nombre de los empleados que trabajan en el proyecto P01. 
select e.nombre
from empleado e
join trabaja t on e.cdemp = t.cdemp
where t.cdpro = 'P01';

-- 7. Listar el nombre de los proyectos en los que trabajan más de 70 horas.  xxxxxxxxxxxxxxx
select p.nombre
from proyecto p
join trabaja t on p.cdpro = t.cdpro
group by p.nombre
having sum(t.nhoras) > 70;
-- En la tabla trabaja la suma de nhoras para cada proyecto no supera las 1000 horas

-- 8. Listar el nombre de los empleados que trabajan en el proyecto P01 y en el proyecto P02 a la vez. 
select e.nombre
from empleado e
join trabaja t on e.cdemp = t.cdemp
where t.cdpro in ('P01', 'P02')
group by e.nombre
having count(distinct t.cdpro) = 2;
-- Ningún empleado trabaja en ambos proyectos

-- 9. Listar el nombre de los empleados que trabajan en el proyecto P01 y que han trabajado más de 20 horas. xxxxxxxxxxxxxx
select e.nombre
from empleado e
join trabaja t on e.cdemp = t.cdemp
where t.cdpro = 'P01' and t.nhoras > 20;
-- Ningún empleado ha trabajado más de 100 horas en el proyecto P01

-- 10. Listar el nombre de los empleados que trabajan en el proyecto P01 y que ganan más de 1.000 euros. xxxxxxxxxxxxxx
select e.nombre
from empleado e
join trabaja t on e.cdemp = t.cdemp
where t.cdpro = 'P01' and e.salario > 1000;
-- Ningún empleado que trabaja en P01 tiene un salario superior a 30.000 euros

-- 11. Listar el nombre de los empleados que trabajan en el departamento de Desarrollo y que ganan más de 1.000 euros xxxxxxxxxxxx
select e.nombre
from empleado e
join departamento d on e.cddep = d.cddep
where d.nombre = 'Desarrollo de software' and e.salario > 1000;
-- Ningún empleado en el departamento "Desarrollo de software" tiene un salario superior a 30000 euros 

-- 12. Listar el nombre de los empleados que trabajan en el proyecto P01 y que ganan más que el empleado E01. 
select e.nombre
from empleado e
join trabaja t on e.cdemp = t.cdemp
where t.cdpro = 'P01' and e.salario > (select salario from empleado where cdemp = 'E01');

-- 13. Obtén toda la información de los empleados y el nombre del departamento al que pertenecen. 
select e.*, d.nombre
from empleado e
join departamento d on e.cddep = d.cddep;

-- 14. Indicar quién es el jefe de departamento de cada empleado. 
select e.nombre, j.nombre
from empleado e
join departamento d on e.cddep = d.cddep
join empleado j on d.cddep = j.cddep and j.cdemp = e.cdjefe;

-- 15. Obtén el código y el nombre de cada empleado con el nombre de su jefe. 
select e.cdemp, e.nombre, j.nombre
from empleado e
left join empleado j on e.cdjefe = j.cdemp;

-- 16. Obtener un listado con los nombres de los distintos departamentos y sus jefes con sus datos personales.
select d.nombre, j.nombre, j.salario, j.ciudad
from departamento d
join empleado j on d.cddep = j.cddep and j.cdemp = d.cddep;
-- No hay jefes asignados en la tabla empleado

-- 17. Listar los proyectos y que aparezcan los empleados que están asignados a cada proyecto. 
select p.nombre, e.nombre
from proyecto p
join trabaja t on p.cdpro = t.cdpro
join empleado e on t.cdemp = e.cdemp;

-- 18. Calcular el total de horas trabajadas por proyecto. 
select p.nombre, sum(t.nhoras)
from proyecto p
join trabaja t on p.cdpro = t.cdpro
group by p.nombre;

-- 19. Empleados que ingresaron en 2023. 
select nombre
from empleado
where year(fecha_ingreso) = 2023;

-- 20. Promedio de salario por departamento. 
select d.nombre, avg(e.salario)
from empleado e
join departamento d on e.cddep = d.cddep
group by d.nombre;

-- 21. Muestra los nombres de los proyectos y su duración en días. xxxxxxxxxxxxxx
select p.nombre, sum(t.nhoras) as total_horas, sum(t.nhoras) / 8 as duracion_dias -- (ASUMIEDO QUE UN DIA TIENE 8H DE TRABAJO)
from proyecto p
join trabaja t on p.cdpro = t.cdpro
group by p.nombre;
-- La tabla proyecto no tiene columnas de fecha inicio y fecha fin // hacerlo con nhoras

-- 22. Calcula el número de empleados por ciudad. 
select ciudad, count(*)
from empleado
group by ciudad;

-- 23. Muéstrame los proyectos con más de 50 horas trabajadas. 
select p.nombre
from proyecto p
join trabaja t on p.cdpro = t.cdpro
group by p.nombre
having sum(t.nhoras) > 50;

-- 24. Muestra el nombre del departamento y la cantidad de proyectos que tiene asignados. 
select d.nombre, count(p.cdpro)
from departamento d
join proyecto p on d.cddep = p.cddep
group by d.nombre;

-- 25. Muestra los departamentos con un salario promedio superior a 1000 y más de 1 empleado. 
select d.nombre
from empleado e
join departamento d on e.cddep = d.cddep
group by d.nombre
having avg(e.salario) > 1000 and count(e.cdemp) > 1;

-- 26. Muestra los proyectos con 2 o más empleados y un total de horas trabajadas superior a 40. 
select p.nombre
from proyecto p
join trabaja t on p.cdpro = t.cdpro
group by p.nombre
having count(distinct t.cdemp) >= 2 and sum(t.nhoras) > 40;

