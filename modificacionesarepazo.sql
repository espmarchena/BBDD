use arepazo;

start transaction;
rollback; 
commit;

-- 1.Inserta un nuevo elemento en el menú, a partir de ahora tendremos una caña sin alcohol.
-- Valdrá lo mismo que la caña y tiene que tener la misma categoría y tipo. Solo tiene que diferenciarse el nombre, que será caña sin alcohol.
insert into menu (Nombre, Descripcion, Tipo, Categoria, PrecioVenta)
select 'Caña sin alcohol', 'Caña con 0% alcohol', Tipo, Categoria, PrecioVenta 
from menu 
where Nombre = 'Caña';

select nombre -- compruebo que se ha guardado
from menu where nombre = 'Caña sin alcohol';


-- 2.Debido a la crisis, aumenta todos los precios de venta del menú un 7%. 
select nombre, PrecioVenta -- compruebo el precio inicialmente
from menu;

update menu 
set PrecioVenta = PrecioVenta * 1.07
where 1 = 1;

-- 3.Añade un pedido de 4 Arepas La Criollita, 1 ración de tequeños y 4 cañas al cliente con email curae@protonmail.couk .Los gastos de envío serán 3.99 
select id from clientes where Email = 'curae@protonmail.couk'; -- Primero busco el id del cliente que sera idCliente en pedidos

-- Inserto el pedido
insert into pedidos (Fecha_pedido, Total, GastosEnvio, SubTotal, IdCliente, Telefono, Direccion, Cod_Postal, Provincia)
select now(),
((4*(select PrecioVenta from menu where Nombre = 'La Criollita') + 1*(select PrecioVenta from menu where Nombre = 'Tequeños') + 4*(select PrecioVenta from menu where Nombre = 'Caña'))*1.21) + 3.99,
3.99,
(4*(select PrecioVenta from menu where Nombre = 'La Criollita') + 1*(select PrecioVenta from menu where Nombre = 'Tequeños') + 4*(select PrecioVenta from menu where Nombre = 'Caña')),
15,
(select Telefono from clientes where id = 15),
(select Direccion from clientes where id = 15),
(select Cod_Postal from clientes where id = 15),
(select Provincia from clientes where id = 15)
from clientes where id = 15;

-- Lleva 3 cosas dentro
insert into pedidoslinea (idPedido, idMenu, Cantidad, PrecioVentaUnitario, IVA)
select 15, (select id from menu where Nombre = 'La Criollita'), 4, (select PrecioVenta from menu where Nombre = 'La Criollita'), 1.21;

insert into pedidoslinea (idPedido, idMenu, Cantidad, PrecioVentaUnitario, IVA)
select 15, (select id from menu where Nombre = 'Tequeños'), 1, (select PrecioVenta from menu where Nombre = 'Tequeños'), 1.21;

insert into pedidoslinea (idPedido, idMenu, Cantidad, PrecioVentaUnitario, IVA)
select 15, (select id from menu where Nombre = 'Caña'), 4, (select PrecioVenta from menu where Nombre = 'Caña'), 1.21;

       
-- 4.Regala 1 ración de tequeños al cliente que más haya gastado en la historia del arepazo. Deberás añadir un pedido a coste 0 y sin gastos de envío. 
select subtotal, idCliente -- busco al cliente que mas ha gastado (idCliente 245)
from pedidos
order by total desc;

-- le añado un pedido a coste 0
insert into pedidos (Fecha_pedido, Total, GastosEnvio, SubTotal, IdCliente, Telefono, Direccion, Cod_Postal, Provincia)
select now(), 0, 0, 0, 245, (select Telefono from clientes where id = 245), (select Direccion from clientes where id = 245), (select Cod_Postal from clientes where id = 245), (select Provincia from clientes where id = 245)
from clientes where id = 245;

select * -- compruebo que haya un pedido a coste 0
from pedidos
where idCliente = 245;

-- 5.Yahoo ha sido absorbido por Microsoft. Todos los correos de Yahoo pasan a ser outlook. Actualiza la bbdd. 
update clientes 
set Email = replace(Email, '@yahoo', '@outlook')
where Email like '%@yahoo%';


-- 6.Borra los elementos del menú que nadie nunca ha pedido. Si es necesario, borra también sus recetas. 
select p.id, c.nombre -- busco los clientes que nunca han hecho pedido
from pedidos p
left join clientes c on c.id = p.idCliente
where p.idCliente is null;


start transaction;
rollback; 
commit;

-- 7.Debido a la sequía, el ‘Tomate Arbol’ ha dejado de subministrarse. Borra todos los elementos del menú que tengan ese ingrediente, asi como sus recetas y el ingrediente.
-- Si hay algún pedido de ese elemento del menu, pon su idmenu a null.
delete from receta -- elimino las recetas con tomate arbol
where idingredientes = (select id from ingredientes where nombre = 'Tomate Arbol');

-- elimino las líneas de pedidos que que tienen fk en menus con tomate arbol
update pedidoslinea
set idmenu = null
where idmenu in (select id from menu where id in (select idmenu from receta where idingredientes = (select id from ingredientes where nombre = 'Tomate Arbol')));

-- elimino los menus que contienen tomate arbol
delete from menu where id in (select idmenu from receta where idingredientes = (select id from ingredientes where nombre = 'Tomate Arbol'));

-- elimino el ingrediente tomate arbol
delete from ingredientes
where nombre = 'Tomate Arbol';

select * from ingredientes where nombre = 'Tomate Arbol'; -- compruebo que el tomate de arbol ha sido eliminado

-- 8.Promoción semanal "2x1 en Cañas". 
-- Para aumentar la clientela los miércoles, crea una promoción permanente de '2x1 en Cañas' que se aplique automáticamente todos los miércoles. La promoción debe: 
-- ● Registrarse en una nueva tabla llamada promociones 
-- ● Aplicar un 50% de descuento (equivalente al 2x1) 
-- ● Estar vigente indefinidamente 
-- ● Mantener relación con el menú original de Cañas" 

create table promociones (
    id int auto_increment primary key,
    nombre varchar(100),
    descripcion varchar(100),
    descuento decimal(5,2),
    diasemana varchar(20),
    idmenu int,
    vigente boolean
);

insert into promociones (nombre, descripcion, descuento, diasemana, idmenu, vigente) values ('2x1 en Cañas', 'promoción 2x1 todos los miércoles', 50.00, 'miércoles',
(select id from menu where nombre = 'Cañas' limit 1), true);


-- 9.  Creación del "Combo Familiar" (nuevo menú promocional) 
-- Para impulsar las ventas, crea un nuevo menú llamado 'Combo Familiar' que incluya: 
-- ● 2 Arepas La Criollita 
-- ● 1 ración de Tequeños 
-- ● 2 Cañas 
-- El precio debe ser un 15% más económico que comprar estos elementos por separado.
-- Asegúrate de que el nuevo menú tenga la misma categoría y tipo que  las Arepas La Criollita, y registra todos los ingredientes necesarios en su receta. 

-- inserto nuevo menu con 15% dto
insert into menu (nombre, descripcion, precioventa, categoria, tipo) values ('Combo Familiar', '2 Arepas La Criollita, 1 ración de Tequeños y 2 Cañas', (2*(select precioventa from menu where nombre = 'Arepa La Criollita' limit 1) +
(select precioventa from menu where nombre = 'Tequeños' limit 1) + 2*(select precioventa from menu where nombre = 'Cañas' limit 1))*0.85, (select categoria from menu where nombre = 'Arepa La Criollita' limit 1),
(select tipo from menu where nombre = 'Arepa La Criollita' limit 1));

-- inserto ingredientes desde 'Arepa La Criollita'
insert into receta (idmenu, idingredientes, cantidadenkg)
select (select id from menu where nombre = 'Combo Familiar' order by id desc limit 1), idingredientes, cantidadenkg*2
from receta
where idmenu = (select id from menu where nombre = 'Arepa La Criollita' limit 1);

-- inserto los ingredientes desde los tequeños
insert into receta (idmenu, idingredientes, cantidadenkg)
select (select id from menu where nombre = 'Combo Familiar' order by id desc limit 1), idingredientes, cantidadenkg
from receta
where idmenu = (select id from menu where nombre = 'Tequeños' limit 1);

-- inserto los ingredientes desde cañas
insert into receta (idmenu, idingredientes, cantidadenkg) select (select id from menu where nombre = 'Combo Familiar' order by id desc limit 1), idingredientes, cantidadenkg*2
from receta
where idmenu = (select id from menu where nombre = 'Cañas' limit 1);

-- 10. Descuento para clientes de Madrid (compensación por retrasos en enero) 
-- Debido a los retrasos en los pedidos durante el año 2021 en la Comunidad de Madrid, aplica un descuento del 10% a todos los pedidos realizados por clientes de esta región en el año 2021.
-- El descuento debe aplicarse al subtotal, manteniendo los gastos de envío originales. 

update pedidos p
join clientes c on p.idcliente = c.id
set subtotal = p.subtotal*0.90, 2
where c.comunidadautonoma = 'Madrid'
and year(p.fecha_pedido) = 2021;


-- 11. Migración de cuentas Hotmail a Outlook (actualización corporativa)
-- Como parte de la migración global de Microsoft, actualiza todas las cuentas de correo @hotmail a @outlook para los clientes de Barcelona.
-- Además, añade la leyenda '[Correo actualizado]' seguida de la fecha actual al final de su dirección, para llevar un registro de esta modificación.

update clientes
set email = concat (replace(email, '@hotmail', '@outlook'),'[Correo actualizado]', now())
where email like '%@hotmail%' and provincia = 'Barcelona';
