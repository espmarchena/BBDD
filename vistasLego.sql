-- Vista 1: Vista de Inventario de Sets LEGO por Colección 
create or replace view VistaInventarioPorColeccion as
select
	coleccion.nombre as nombreColeccion,
	lego.piezas,
	lego.minifiguras
from
	coleccion
join
	lego on coleccion.id = lego.id;

-- comprobamos que funciona
select * from VistaInventarioPorColeccion; 

-- usa la vista para contar cuantas colecciones diferentes hay
select count(distinct nombreColeccion) as totalColecciones from VistaInventarioPorColeccion;
-- sin usar la vista:
select count(*) as totalColecciones from coleccion; -- COUNT es una funcion de agregacion que CUENTA FILAS



-- Vista 2: Vista de Clientes con Pedidos Recientes 
select 
	clientes.nombre, pedidos.fecha
from
	clientes 
join 
	pedidos on clientes.id = pedidos.idCliente
where
	pedidos.fecha >= date_sub((select max(fecha) from pedidos), interval 1 month); -- select max(fecha) me da la fecha mas alta, osea la mas reciente
							-- (select fecha from pedidos order by fecha desc limit 1)
	
create or replace view VistaClientesPedidosRecientes as
select
	clientes.nombre,
	pedidos.fecha
from
	clientes
join 
	pedidos on clientes.id = pedidos.idCliente
where
	pedidos.fecha >= date_sub((select max(fecha) from pedidos), interval 1 month);

select * from VistaClientesPedidosRecientes; -- para visualizar la tabla de la vista

-- ---------------------------------------

-- 1. Crea una vista que muestre los Legos más vendidos por coleccion comprobamos que funciona:
create or replace view VistaLegosMasVendidosPorColeccion as
select
    c.nombre as nombreColeccion,
    l.nombre as nombreLego,
    p.ciudad,
    count(d.idLego) AS cantidadVendida
from
    coleccion c
join
    lego l on c.id = l.idColeccion
join
    detalle d on l.id = d.idLego
join
	pedidos p on p.id = d.idPedido
group by
    c.nombre, l.nombre
order by
    c.nombre, cantidadVendida desc;

select * from VistaLegosMasVendidosPorColeccion; -- para visualizar la tabla de la vista

-- Dime las 10 ciudades con más legos vendidos 
select 
    p.ciudad,
    sum(vlmvpc.cantidadVendida) as totalLegosVendidos
from 
    VistaLegosMasVendidosPorColeccion vlmvpc
join 
    lego l on vlmvpc.nombreLego = l.nombre
join 
    detalle d on l.id = d.idLego
join 
    pedidos p on d.idPedido = p.id
group by 
    p.ciudad
order by 
    totalLegosVendidos desc
limit 10;

-- Pista : usamos subconsulta para saber el id del lego más vendido


-- ¿ Existe alguna coleccion que no haya vendido ningún LEGO?
select 
    c.nombre as coleccionSinVentas
from 
    coleccion c
where 
    c.nombre  not in
    (
        select distinct nombreColeccion 
        from VistaLegosMasVendidosPorColeccion
    );

	


-- 2. Crea una vista que muestre clientes que han comprado algún Lego en el año 2015
-- comprobamos que funciona
-- ¿A qué ciudades pertenecen esos clientes?


-- 3. Crea una vista que calcula el valor promedio de cada colección de LEGOs.
-- comprobamos que funciona
-- ¿Cuál es la colección que genera mayores ingresos promedio por pedido?


--  4. Crea una vista que muestre clientes que han comprado algún Lego de Marvel
-- comprobamos que funciona


