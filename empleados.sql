use empleados;

 -- ● Mostrar el DNI de los empleados son de Barcelona, Madrid,Sevilla o Málaga, que no se llaman ni Antonio ni Luis y que su primer apellido es García.
select e.dni, e.nombre
from empleado e
where e.ciudad in ('Madrid', 'Barcelona', 'Sevilla', 'Málaga')
and e.nombre not in ('Antonio', 'Luis')
and e.prApellido = 'García';

 -- ● Mostrar el DNI de los empleados no son de Sevilla, pero sí son de Barcelona o de Madrid y que la primera letra de su nombre es una M.
select e.dni, e.nombre, e.ciudad
from empleado e
where e.ciudad not in ('Sevilla')
and e.ciudad in ('Barcelona', 'Madrid')
and (e.nombre like 'L%' or e.nombre like 'l%');

 -- ● Mostrar el DNI de los empleados que son de Sevilla pero no son de Barcelona o de Madrid y que la primera letra de su nombre no es una M.
select e.dni, e.nombre, e.ciudad
from empleado e
where e.ciudad in ('Sevilla')
and e.ciudad not in ('Barcelona', 'Madrid')
and (e.nombre not like 'M%' or e.nombre like 'm%');

 -- ● Mostrar el nombre y el primer apellido de aquellos empleados que viven en Valencia, Vizcaya o en una ciudad cuya última letra sea a, ordenados descendentemente por el primer apellido.
select e.nombre, e.prApellido, e.ciudad
from empleado e
where e.ciudad in ('Valencia', 'Vizcaya')
and e.ciudad like '%a'
order by e.prApellido asc;

 -- ● Mostrar el DNI de aquellos empleados que son de Barcelona y que se llaman Antonio, Luis, Iván o Pedro y que se apellidan García o Cantos.
select e.dni, e.nombre, e.prApellido
from empleado e
where e.ciudad in ('Barcelona')
and e.nombre in ('Antonio', 'Luis', 'Iván',' Pedro')
and e.prApellido in ('García', 'Cantos');

 -- ● Mostrar el nombre y los apellidos de los empleados cuyo DNI contenga un 4 y el nombre sea Rosa, Luis, Ramón o Antonio, ordenados ascendentemente por el primer apellido.
select e.nombre, e.prApellido, e.dni
from empleado e
where e.dni like '%4%'
and e.nombre in ('Rosa', 'Luis', 'Ramón', 'Antonio')
order by e.prApellido asc;

 -- ● Mostrar el DNI de los empleados que se llaman Antonio y que su primer apellido no contenga la letra c y su segundo apellido comience y termine por a.
select e.dni, e.nombre
from empleado e
where e.nombre in ('Antonio')
and e.prApellido not like '%c%'
and (e.sgApellido LIKE 'a%' OR e.sgApellido LIKE 'A%');

 -- ● Mostrar el nombre y primer apellido de aquellos empleados cuyo DNI está entre 29000000 y 44000000
 -- y su segundo apellido sea García, Gómez o Sánchez, ordenados por el segundo apellido.
select e.nombre, e.prApellido
from empleado e
where e.dni between 29000000 and 44000000
and e.sgApellido in ('García', 'Gómez', 'Sánchez')
order by e.sgApellido asc;

 -- ● Mostrar el DNI de aquellos empleados que no tengan segundo apellido.
select e.dni, e.nombre
from empleado e
where e.sgApellido is null;
