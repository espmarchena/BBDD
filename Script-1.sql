select c.nombre, p.Total from clientes c
join pedidos p on c.idCliente = p.idCliente;

-- buscar el libro mas vendidos de Gabriel García Márquez
select l.titulo, sum(d.cantidad) -- buscar titulo del libro y la suma de las cantidades(en tabla detalle)
-- as vecesVendido -- podemos poner un alias a la busqueda del select
from libros l -- en la tabla libros
join detalle d on l.idLibro = d.idLibro -- unir la tabla detalles con el pk de libro y la fk de detalle
WHERE l.autores = 'Gabriel García Márquez' -- que el nombre del libro sea X
group by l.titulo -- agrupar por el titulo de los libros, pq puede haber mas de un libro y nosotros buscamos un libro concreto
order by sum(d.cantidad) desc -- ordenar las cantidades de mas a menos
-- order by vecesVendido des -- ordenar usando el alias
limit 1; -- que solo me salga el primero

