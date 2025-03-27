use arepazo;

-- Saca la lista de todos los nombres, apellidos y email del arepazo de la provincia de Sevilla ordenada por orden alfabético de apellidos y nombre:
select Nombre, Apellido, Email,Provincia 
from clientes
where Provincia like '%Sevilla%'
order by Apellido, Nombre;

-- De cada cliente de Sevilla, saca aquellos que nunca hayan realizado algún pedido, si es que lo hay:
select c.Nombre, c.Apellido, c.Email, p.IdCliente from clientes c
left join pedidos p on c.id =p.IdCliente 
where p.IdCliente is null;

-- Dame la lista de nombres y apellidos de los clientes de Barcelona indicando también el número de pedidos que ha realizado cada uno y el total gastado en todos sus pedidos:
select c.Nombre, c.Apellido, count(p.Id) as NumeroPedidos, sum(p.Total) as TotalGastado
from clientes c
join pedidos p on c.id = p.IdCliente
where c.Provincia = 'Barcelona'
group by c.Nombre, c.Apellido;

-- Localiza aquellos elementos del menú que nunca nadie ha pedido:
select m.Nombre
from menu m
left join pedidoslinea pl on m.Id = pl.IdMenu
where pl.IdMenu is null;

-- Saca una lista de los elementos del menú donde se pueda ver el nombre, el precio de venta y el coste de fabricación (la lista de costes de sus ingredientes):
select m.Nombre, m.PrecioVenta, sum(r.CantidadEnKg * i.PrecioKg) as CosteFabricacion
from menu m
join receta r on m.Id = r.idMenu
join ingredientes i on r.idIngredientes = i.Id
group by m.Id;

-- Saca en una consulta, el nombre del menú, la descripción, el precio de venta, y el peso de sus ingredientes:
select m.Nombre, m.descripcion, m.PrecioVenta, sum(r.CantidadEnKg) as PesoIngredientes
from menu m
join receta r on m.Id = r.idMenu
group by m.Id;

-- Dame las provincias con más de 6 clientes descartando las provincias que están a NULL en la tabla clientes:
select Provincia, count(*) as NumeroClientes
from clientes
where Provincia <> ' '
group by Provincia
having count(*) > 6;

-- Saca la lista de los ingredientes que se utilizan en más de 3 menús diferentes:
select i.Nombre, count(distinct r.idMenu) as MenusUsados
from ingredientes i
join receta r on i.Id = r.idIngredientes
group by i.Nombre
having count(distinct r.idMenu) > 3
order by MenusUsados desc;

-- Dame el nombre y el precio de venta del menú más caro de cada categoría:
select m.Nombre, m.PrecioVenta, cm.descripcion as Categoria
from menu m
join categoriasmenu cm on m.Categoria = cm.Id
where m.PrecioVenta = (
  select max(PrecioVenta)
  from menu
  where Categoria = m.Categoria
)
group by m.Categoria
order by m.PrecioVenta desc;

-- Saca una lista de los clientes que han realizado pedidos en el último mes, indicando el número de pedidos realizados:

select c.nombre, c.apellido, count(p.id) as numeropedidos
from clientes c
join pedidos p on c.id = p.idcliente
where p.fecha_pedido >= date_sub(
    (select max(fecha_pedido) from pedidos), 
    interval 1 month
)
group by c.nombre, c.apellido;

-- Encuentra los clientes que hayan gastado más de 500€ en total en pedidos:
select c.Nombre, c.Apellido, sum(p.Total) as TotalGastado
from clientes c
join pedidos p on c.id = p.IdCliente
group by c.Nombre, c.Apellido
having sum(p.Total) > 100
order by TotalGastado desc;

-- Lista los menús más vendidos y la cantidad total vendida de cada uno:
select m.Nombre, sum(pl.Cantidad) as CantidadVendida
from menu m
join pedidoslinea pl on m.Id = pl.IdMenu
group by m.Nombre
order by CantidadVendida desc;