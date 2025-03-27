use tiendaLego;

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


