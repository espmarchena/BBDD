use tiendaLego;

-- Consultas:
-- 1.Listado de Legos con precio superior a la media:
select nombre, precio from lego
where precio > (select avg(precio) from lego)
order by precio;

-- 2. Dime el nombre de los clientes que han realizado pedidos en el año 2023.
select distinct c.nombre, year (p.fecha) from clientes c 
join pedidos p on c.id =p.idCliente
where year (p.fecha )=2023;

-- 3. Dime los Legos de la colección Star Wars con stock disponible (piezas > 0):
select l.nombre,c.nombre from lego l 
join coleccion c on l.idColeccion =c.id
where c.nombre like '%Wars%' and l.piezas>0;

-- 4. Pedidos con un valor total superior a 500 euros
select id, total from pedidos 
where total >500
order by total;

-- 5. Lego más caro de cada colección:
select c.nombre as nombrecoleccion,l.nombre as legonombre,l.precio as preciolego
from lego l
join coleccion c on l.idcoleccion = c.id
where l.precio = (
        select max(precio)
        from lego l2
        where l2.idcoleccion = l.idcoleccion
        )
group by c.nombre 
order by l.precio desc;

-- 6. Clientes que han realizado más de un pedido:
 select c.nombre, count(p.id)numeroDePedidos from clientes c 
 join pedidos p on c.id = p.idCliente
 group by c.nombre
 having numeroDePedidos >1
 order by numeroDePedidos;

-- 7. Legos que no se han vendido en ningún pedido:


-- 8. Total de ventas por colección:


-- 9. Clientes que han comprado un Lego de Batman:
select c.nombre NombreCliente, l.nombre NombreLego from clientes c 
join pedidos p on p.idCliente =c.id
join detalle d on p.id =d.idPedido
join lego l on d.idLego =l.id
where  l.nombre like '%batman%';

-- 10. Dime la pieza lego Lego con mayor cantidad vendida en un solo pedido:




 -- Modificando la base de datos:

 -- 1. Añádete como cliente en la tienda.
select max(id)
from clientes; -- compruebo el ultimo id ya que no es autoincremental 
								-- (lo hago asi pq no es autoincremental) -> (select max(c.id)+1 from clientes c)
insert into clientes values ((select max(c.id)+1 from clientes c), 'Esperanza', '666666666', 'miemail@gmail.com', 'Calle Ejemplo 123', '41013', 'Sevilla');
-- vamos a la tabla, vemos los campos obligatorios y los ponemos todos y en orden con el tipo correcto. Si es atributo y no tiene valor, hay que ponerlo NULL

 -- 2. Borra todos los legos anteriores al 2003 que no se hayan comprado nunca.
start transaction; -- ejecuto para empezar transicion, ejecuto delete

-- primero compruebo los legos anteriores al 2003 que no se hayan comprado nunca. Una vez que haga el delete, si no arroja nada aqui, estaría bien hecho
select id from lego
where anyo_publicacion < 2003
and id not in (select distinct idLego from detalle); -- subconsulta de los id distintos que haya en la tienda Lego (está en la tabla detalles)

delete from lego
where anyo_publicacion < 2003
and id not in (select distinct idLego from detalle);

rollback; -- si el delete la caga, ejecuto esto
commit; -- si el delete funciona bien, ejecuto esto


 -- 3. Borra los clientes que no han comprado nunca nada.
start transaction;

-- compruebo los clientes que no han comprado nunca nada
select id from clientes 
where id not in (select distinct idCliente from pedidos); -- "donde el id no esté en los pedidos"

delete from clientes
where id not in (select distinct idCliente from pedidos); 

rollback; 
commit;


 -- 4. Incrementa un 7% el precio de todos los legos de más de 1000 piezas.
update lego -- modificar datos "actualiza tabla lego"
set precio = precio * 1.07
where piezas > 1000; 


 -- 5. Todos los pedidos con destino a la ciudad de Palma de Mallorca, tienen mal calculados los gastos de envío. deberían ser 9.99. Arréglalo, aunque sean pedidos del pasado.
update pedidos
set gastosEnvio = 9.99, total = subtotal + 9.99
where ciudad like '%mallorca%';
 

-- 6. Por un error informático, todas las ciudades que empiezan por c están en minúsculas, cámbialo para que empiecen por una C mayúscula.
update clientes
set ciudad = concat(upper(substring(ciudad, 1, 1)), lower(substring(ciudad, 2, 6))) -- anidacion de funciones. concat -> concatena la C con iudad para modificarlo como se pide
where ciudad like 'c%';


-- 7. La clienta Simone Molina con email simonemolina1894@google.ca ha pedido darse de baja, borrarla de la tabla clientes. Borra todo lo estrictamente necesario. A ser posible, sin borrar pedidos.
start transaction;

-- Primero verifico si tiene pedidos asociados
select count(*) from pedidos 
where idCliente = (select id from clientes where nombre = 'Simone Molina' and email = 'simonemolina1894@google.ca');

-- Hay que ir eliminando en cascada, ya que laa foreign key no permite hacerlo directo:
-- Primero borro los detalles de pedido asociados a los pedidos del cliente
delete from detalle 
where idPedido in (select id from pedidos where idCliente = (
        select id from clientes 
        where nombre = 'Simone Molina' and email = 'simonemolina1894@google.ca'));

-- Luego borro los pedidos del cliente
delete from pedidos
where idCliente = (select c.id from clientes c where nombre = 'Simone Molina' and email = 'simonemolina1894@google.ca');

-- Finalmente borro al cliente
delete from clientes 
where nombre = 'Simone Molina' AND email = 'simonemolina1894@google.ca';

rollback; 
commit;


-- 8. El cliente con email calvinmuoz8516@google.com quiere hacer un pedido de 1 caja de cada lego de la colección de Spider-Man.
-- Añade ese pedido a la base de datos.
start transaction;

-- Para insertar el pedido añado todos los valores de la tabla pedidos con los datos de esta persona usando subconsultas
insert into pedidos values ((select max(p.id)+1 from clientes p), curdate(), 0, 9.99, 0, (select id from clientes where email = 'calvinmuoz8516@google.com'),
(select nombre from clientes where email = 'calvinmuoz8516@google.com'), (select direccion from clientes where email = 'calvinmuoz8516@google.com'),
(select codpostal from clientes where email = 'calvinmuoz8516@google.com'), (select ciudad from clientes where email = 'calvinmuoz8516@google.com'));
 
-- Para insertar los detalles del pedido añado todos los valores de la tabla detalles con los datos del lego
-- en la primera cojo el id del lego de la coleccion
-- en la segunda subconsulta cojo el precio
-- 
insert into detalle values ((select max(p.id) from pedidos p), (select l.idLego from lego l join coleccion c on c.id = l.idColeccion), 1, (select l.precio from lego l)
where (select l.idColeccion from lego l where nombre like 'Spider-Man%');
 
-- last_insert_id() from tabla // de una inserccion que haya hecho
-- te da el ultimo id insertado, solo si es autoincremental

update pedidos p --  actualizo los detalles
set subtotal = (select sum(d.cantidad * d.precioUnitario) from detalle d where d.idPedido = p.id),
total = subtotal + gastosEnvio where p.id = (select max(id) from pedidos);

rollback; 
commit;

-- 9. Nuestro departamento de Marketing ha decidido regalar el set de lego 5751 al cliente que más legos de la colección star wars ha comprado.
-- Añade un pedido a coste 0 a ese cliente con dicho set de lego (añadir su linea)
select cl.id, cl.nombre, sum(d.cantidad) as total
from clientes cl
join pedidos p on cl.id = p.idCliente
join detalle d on p.id = d.idPedido
join lego l on d.idLego = l.id
join coleccion c on l.idColeccion = c.id
where c.nombre like '%Star Wars%'
group by cl.id
order by total desc
limit 1;
-- consulta el cliente que mas lego starwars ha comprado, group by, sum, y varios join // tiene que salir el 318


