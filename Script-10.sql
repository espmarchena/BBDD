use empleados;
 
 
-- 1. Lista el primer apellido de todos los empleados.
select apellido1 from empleado;

-- 2. Lista el primer apellido de los empleados eliminando los apellidos que estén
-- repetidos.
select distinct apellido1 from empleado;

-- 3. Lista todas las columnas de la tabla empleado.
select * from empleado;

-- 4. Lista el nombre y los apellidos de todos los empleados.
select nombre, apellido1, apellido2 from empleado;

-- 5. Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado.
select id_departamento from empleado;  -- cuando es una FK hay que poner distinct porque puede estar duplicado, en una PK no

-- 6. Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado, eliminando los identificadores que aparecen repetidos.
select distinct id_departamento from empleado; -- cuando es una FK si hay que poner distinct porque puede estar duplicado, en una PK no

-- 7. Lista el nombre y apellidos de los empleados en una única columna.
select concat (nombre, ' ', apellido1, ' ', apellido2) as nombre_completo from empleado;

-- 8. Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.
select upper(concat(nombre, ' ', apellido1, ' ', apellido2)) as nombre_completo_mayus from empleado;

-- 9. Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
select lower(concat(nombre, ' ', apellido1, ' ', apellido2)) as nombre_completo_minus from empleado;

-- 10.Lista el identificador de los empleados junto al nif, pero el nif deberá aparecer en dos columnas,
-- una mostrará únicamente los dígitos del nif y la otra la letra.
select id,
substring (nif, 1, 8) as numeros_nif,
substring (nif, 9) as letra_nif
from empleado;

-- 11. Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone.
-- *Para calcular este dato tendrá que restar al valor del presupuesto inicial (columna presupuesto) los gastos que se han generado (columna gastos).
-- *Tenga en cuenta que en algunos casos pueden existir valores negativos. Utilice un alias apropiado para la nueva columna columna que está calculando.
select nombre, presupuesto - gastos as presupuesto_actual from departamento;

-- 12.Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
select nombre, presupuesto - gastos as presupuesto_actual from departamento order by presupuesto_actual asc;

-- 13.Lista el nombre de todos los departamentos ordenados de forma ascendente.
select nombre from departamento order by nombre asc;

-- 14.Lista el nombre de todos los departamentos ordenados de forma descendente.
select nombre from departamento order by nombre desc;

-- 15.Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su nombre.
select apellido2, apellido1, nombre from empleado order by apellido1, apellido2 asc, nombre asc;

-- 16.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
select nombre, presupuesto from departamento order by presupuesto desc limit 3;

-- 17.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
select nombre, presupuesto from departamento order by presupuesto asc limit 3;

-- 18.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.
select nombre, gastos from departamento order by gastos desc limit 2;

-- 19.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.
select nombre, gastos from departamento d order by gastos asc limit 2;

-- 20.Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La tercera fila se debe incluir en la respuesta.
-- La respuesta debe incluir todas las columnas de la tabla empleado.
select * from empleado limit 2 offset 2;

-- 21.Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a 150000 euros.
select nombre, presupuesto from departamento where presupuesto >= 150000;

-- 22.Devuelve una lista con el nombre de los departamentos y el gasto, de aquellos que tienen menos de 5000 euros de gastos.
select nombre, gastos from departamento where gastos < 5000;

-- 23.Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
select nombre, presupuesto from departamento where presupuesto >= 100000 and presupuesto <= 200000;

-- 24.Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
select nombre, presupuesto from departamento where not (presupuesto >= 100000 and presupuesto <= 200000);

-- 25.Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
select nombre, presupuesto from departamento where presupuesto between 100000 and 200000;

-- 26.Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
select nombre, presupuesto from departamento where not presupuesto >= 100000 and presupuesto <= 200000;

-- 27.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean mayores que el presupuesto del que disponen.
select nombre, gastos, presupuesto from departamento where gastos < presupuesto;

-- 28.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean menores que el presupuesto del que disponen.

-- 29.Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean iguales al presupuesto del que disponen.

-- 30.Lista todos los datos de los empleados cuyo segundo apellido sea NULL.

-- 31.Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.

-- 32.Lista todos los datos de los empleados cuyo segundo apellido sea López.

-- 33.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Sin utilizar el operador IN.

-- 34.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Utilizando el operador IN.

-- 35.Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento 3.

-- 36.Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5
