-- facturas, compras, vinos

-- Supongamos que la fecha de hoy es 28 de junio de 2020, y queremos insertar los registros de las facturas asociadas a los pedidos de hoy.
-- Podemos utilizar el siguiente select para generar los datos de las facturas:

SELECT  p.date, p.client_id, p.quantity * w.price as amount, 
	CONCAT(p.quantity, ' bottles of ', p.wine_name) description, p.order_id 
from purchase p
join wine w ON w.name = p.wine_name
where p.date = '2020-06-28'; 


-- Si simplemente añadimos una cláusula INSERT antes de la consulta, podemos insertar el resultado de la consulta en la tabla wine como podemos ver en el siguiente ejemplo:

INSERT INTO invoice (date, client_id, amount, description, 
order_id) 
SELECT p.date,p.client_id, p.quantity * w.price as amount, 
	CONCAT(p.quantity, ' bottles of ', p.wine_name) description, p.order_id 
FROM purchase p 
JOIN wine w ON w.name = p.wine_name 
WHERE p.date = '2020-06-28';

-- Supongamos que en un día determinado, accidentalmente ejecutamos el INSERT dos veces, y nuestros clientes recibieron dos facturas por cada pedido como resultado. No queremos repetir el mismo error en el futuro. 
-- Para evitarlo, añadimos una subconsulta a la sentencia INSERT para ver si ya existe una factura con el mismo order_id.
-- La siguiente es la nueva versión de la consulta INSERT. La subconsulta añadida al final identifica las facturas que ya existen, y la consulta externa las descarta utilizando el operador NOT IN.

INSERT INTO invoice (date, client_id, amount, description, order_id) 
SELECT p.date,p.client_id,p.quantity * w.price as amount, 
      CONCAT(p.quantity, ' bottles of ', p.wine_name) note, p.order_id 
FROM   purchase p 
JOIN   wine w ON w.name = p.wine_name 
WHERE  p.date = '2020-06-28' 
     AND  p.order_id NOT IN (SELECT order_id -- evita que insertes datos repetidos
                          		FROM invoice i 
                         		WHERE i.order_id=p.order_id);

-- Vamos a crear un UPDATE para mantener actualizado nuestro stock de botellas de vino.
-- Ejecutaremos un UPDATE al final del día para reflejar lo que hemos vendido hoy.

UPDATE wine w 
SET stock = stock - ( 
             SELECT SUM (quantity) 
             FROM purchase p 
             WHERE date = CURRENT_DATE() AND p.wine_name = w.name); 

