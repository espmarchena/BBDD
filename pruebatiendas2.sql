create database pruebatiendas2;

use pruebatiendas2;

CREATE TABLE TIENDAS (
nif varchar(10),
nombre varchar(20),
direccion varchar(20),
poblacion varchar(20),
provincia varchar(20),
codpostal int
);

alter table TIENDAS add constraint PKTIENDAS primary key (nif);

alter table TIENDAS MODIFY NOMBRE VARCHAR(30);

alter table TIENDAS MODIFY NOMBRE VARCHAR(30) not null;

create table fabricantes(
cod_fabricante int not null,
nombre varchar(15),
pais varchar(15)
);

alter table fabricantes add constraint pkfabricantes primary key (cod_fabricante);

create table articulos(
articulo varchar(20),
cod_fabricante int not null,
peso decimal (10,2),
categoria varchar(10),
precio_venta decimal(10,2),
precio_costo decimal (10,2),
existencias int
);

alter table articulos add constraint pkprimaria primary key (articulo, cod_fabricante, peso, categoria);

alter table articulos add nif varchar(10) not null;

alter table articulos add CONSTRAINT fkDNI FOREIGN KEY (nif) REFERENCES tiendas(nif),
add CONSTRAINT pkfabricantes FOREIGN KEY (cod_fabricante) references fabricantes(cod_fabricante);

alter table articulos add constraint fkprecioventa check (precio_venta>0);

alter table articulos add constraint fkpreciocosto check (precio_costo>0);

alter table articulos add constraint fkpeso check (peso>0);

alter table articulos add constraint fkcategoria check (categoria in ('primera', 'segunda', 'tercera'));

create table ventas(
nif varchar(19),
articulo varchar(20),
cod_fabricante int not null,
peso decimal (10,2),
categoria varchar (10),
fecha_venta date,
unidades_vendidas int
);

alter table ventas add constraint pkprimaria primary key (nif, articulo, cod_fabricante, peso, categoria, fecha_venta);

alter table ventas add CONSTRAINT fkniftiendas FOREIGN KEY (nif) REFERENCES tiendas(nif);

alter table ventas add constraint fkforanea foreign key (articulo, cod_fabricante, peso, categoria) references articulos(articulo, cod_fabricante, peso, categoria);

alter table ventas add constraint fkunidadesvendidas check (unidades_vendidas>0);

alter table ventas add constraint fkcategoria check (categoria in ('primera', 'segunda', 'tercera'));

create table pedidos (
nif varchar (10),
articulo varchar(20),
cod_fabricante int not null,
peso decimal (10,2),
categoria varchar(10),
fecha_pedido date,
unidades_pedidas int,
existencias int
);

alter table pedidos add constraint pkprimaria primary key (nif, articulo, cod_fabricante, peso, categoria, fecha_pedido);

alter table pedidos add CONSTRAINT fknifpedidos FOREIGN KEY (nif) REFERENCES tiendas(nif);

alter table pedidos add CONSTRAINT fkde4 FOREIGN KEY (articulo, cod_fabricante, peso, categoria) REFERENCES articulos(articulo, cod_fabricante, peso, categoria); 

alter table pedidos add constraint fkunidadesvendidas check (unidades_pedidas>0);

alter table pedidos add constraint fkcategoria check (categoria in ('primera', 'segunda', 'tercera'));
