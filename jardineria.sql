use jardineria;

-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigo_oficina, ciudad 
FROM oficina;

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono
FROM oficina
WHERE pais = 'España';

-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
select nombre, apellido1, apellido2, email
from empleado
where codigo_jefe = '7';

-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select puesto, nombre, apellido1, apellido2, email 
from empleado
where puesto = 'Director General';

-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
 select nombre, apellido1, apellido2, puesto
 from empleado
 where puesto <> 'Representante Ventas';

-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
select nombre_contacto
from cliente
where pais = 'Spain';

-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select distinct estado
from pedido;

-- 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008.
-- Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos.
-- Resuelva la consulta:
-- ● Utilizando la función YEAR
SELECT DISTINCT codigo_cliente -- selecciona los códigos de cliente únicos (elimina duplicados)
FROM pago -- de la tabla pago
WHERE YEAR(fecha_pago) = 2008; -- filtra los pagos realizados en el año 2008 utilizando la función YEAR para extraer el año de la columna fecha_pago
-- ● Sin utilizar ninguna de las funciones anteriores.
SELECT DISTINCT codigo_cliente
FROM pago
WHERE fecha_pago >= '2008-01-01' AND fecha_pago <= '2008-12-31'; -- filtra los pagos realizados entre el 1 de enero de 2008 y el 31 de diciembre de 2008.
-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
from pedido
where fecha_entrega > fecha_esperada;

----- JOIN

-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
select c.nombre_cliente, e.nombre, e.apellido1, e.apellido2 -- selecciona (de la tabla cliente) el nombre del cliente, (de la tabla empleado) el nombre del representante de ventas y (de la tabla empleado) sus dos apellidos.
from cliente c --  indica que la tabla principal es cliente y le asigna el alias c
join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado; -- Realiza un JOIN con la tabla empleado (alias e) utilizando la clave foránea codigo_empleado_rep_ventas en cliente y la clave primaria codigo_empleado en empleado.

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
select c.nombre_cliente 
from cliente c
join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado -- reflexiva
join pago p on c.codigo_cliente = p.codigo_cliente; 

-- X 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
select distinct c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
from cliente c
join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
where c.codigo_cliente not in (select codigo_cliente from pago);

-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select distinct c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad
from cliente c
join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
join pago p on c.codigo_cliente = p.codigo_cliente
join oficina o on e.codigo_oficina = o.codigo_oficina;
 
-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select distinct c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad
from cliente c
join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
join oficina o on e.codigo_oficina = o.codigo_oficina
where c.codigo_cliente not in (select codigo_cliente from pago);
 
-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select distinct o.linea_direccion1, o.linea_direccion2, o.codigo_postal, c.ciudad
from oficina o
join empleado e on o.codigo_oficina = e.codigo_oficina
join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
where c.ciudad = 'Fuenlabrada';
 
-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select distinct c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad
from cliente c
join empleado e on c.codigo_empleado_rep_ventas = e.codigo_empleado
join oficina o on e.codigo_oficina = o.codigo_oficina;
 
-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
select e.nombre, e.apellido1, e.apellido2, j.nombre
from empleado e
join empleado j on e.codigo_empleado = j.codigo_jefe;
 
-- 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
select distinct e.nombre, j.nombre, s.nombre
from empleado e
join empleado j on e.codigo_empleado = j.codigo_jefe
join empleado s on j.codigo_jefe = s.codigo_jefe;
 
-- 10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
select distinct c.nombre_cliente
from cliente c
join pedido p on c.codigo_cliente = p.codigo_cliente
where p.fecha_entrega > p.fecha_esperada;
 
-- 11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
select distinct g.gama, c.nombre_cliente
from gama_producto g
join producto p on g.gama = p.gama
join detalle_pedido dp on p.codigo_producto = dp.codigo_producto
join pedido pd on dp.codigo_pedido = pd.codigo_pedido
join cliente c on pd.codigo_cliente = c.codigo_cliente;