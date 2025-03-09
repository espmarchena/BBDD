-- Ejercicio 1

create database ExamenDDLcorregido;
use ExamenDDLcorregido;

-- Ejercicio 2

create table persona
(
id int auto_increment primary key,
nombre varchar (50),
apellidos varchar (50)
);

alter table persona add column edad int;

-- Ejercicio 3

create table jugador
(
id int auto_increment primary key,
nombre varchar (50),
apellidos varchar (50)
);

create table equipo
(
id int auto_increment primary key,
nombre varchar (50)
);

alter table equipo add constraint fkIdJugador foreign key (id) references jugador (id);

-- Ejercicio 4

create table CARRETESFOTOS
(
id int auto_increment primary key,
nombre varchar (50)
);

drop table CARRETESFOTOS; 

-- Ejercicio 5

create table libros
(
isbn varchar(10),
titulo varchar(50)
);

alter table libros modify column isbn varchar(13);

-- Ejercicio 6

create table videojuego
(
id int auto_increment primary key,
nombre varchar (50),
precio int 
);

alter table videojuego drop column precio;
alter table videojuego add column precio decimal (4,2);

-- Ejecicio 7

create table cliente
(
id int auto_increment primary key,
nombre varchar (50),
email varchar (50)
);

create table pedido
(
id int auto_increment primary key,
nombre varchar (100),
precio decimal (5,2)
);

alter table pedido add constraint fkIdCliente foreign key (id) references cliente (id);

create table menu
(
id int auto_increment primary key,
nombre varchar (50),
precio decimal (5,2)
);

create table pedidosLinea
(
idPedido int,
idMenu int,
cantidad int,
precio decimal (5,2)
);

alter table pedidosLinea add constraint fkPedido foreign key (idPedido) references pedido (id);
alter table pedidosLinea add constraint fkMenu foreign key (idMenu) references menu (id);
alter table pedidosLinea add constraint pkPedidosLinea primary key (idPedido, idMenu);


create table ingredientes
(
id int auto_increment primary key,
nombre varchar (50),
precioKg decimal (6,2)
);

create table receta
(
idMenu int,
idIngrediente int,
cantidadEnKg int
);

alter table receta add constraint fkRecetaMenu foreign key (idMenu) references menu (id);
alter table receta add constraint fkRecetaIngrediente foreign key (idIngrediente) references ingredientes (id);
alter table receta add constraint pkReceta primary key (idMenu, idIngrediente);

-- Ejercicio 8

create table ninio
(
id int auto_increment primary key,
nombre varchar (50),
apellidos varchar (50),
fechaNacimiento date,
valoracion int
);

alter table ninio add constraint ckValoracion check (valoracion in ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10'));

create table direccion
(
id int auto_increment primary key,
calle varchar (50),
numero int,
ciudad varchar (50),
codigoPostal int
);

alter table direccion add constraint fkDireccionNinio foreign key (id) references ninio (id);

create table regalo
(
id int auto_increment primary key,
nombre varchar (50),
peso decimal (10,2)
);

create table regaloNinio
(
idNinio int,
idRegalo int
);

alter table regaloNinio add constraint fkIdNinio foreign key (idNinio) references ninio (id);
alter table regaloNinio add constraint fkIdRegalo foreign key (idRegalo) references regalo (id);
alter table regaloNinio add constraint pkRegaloNinio primary key (idNinio, idRegalo);