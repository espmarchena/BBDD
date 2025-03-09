-- 1
create database ExamenDDL_Esperanza_Marchena2;

use ExamenDDL_Esperanza_Marchena2;

-- 2 
create table personas (
id int primary key,
nombre varchar (50),
apellidos varchar (50)
);

alter table personas add column edad int;

-- 3
create table jugador (
id int primary key,
nombre varchar (50),
apellidos varchar (50)
);

create table EQUIPO (
id int primary key,
nombre varchar (50)
);

alter table equipo add constraint fkIdJugador foreign key (id) references jugador (id);
-- en la tabla equipo que es la de mayor cardinalidad
-- creo la FK del id del jugador
-- primer parentesis apunta al atributo de la tabla hija
-- referencia a la tabla padre, entre parentesis el atributo al que apunta

-- 4
create table carretesfotos(
id int primary key,
nombre varchar (50)
);

drop table carretesfotos;

-- 5
create table libros (
isbn varchar(50),
titulo varchar (100)
);

alter table libros modify column isbn varchar(13);

-- 6
create table videojuego(
id int primary key,
nombre varchar (50),
precio int
);

alter table videojuego modify column precio decimal (4,2);

-- 7
create table cliente ( -- 1
id int primary key,
nombre varchar (50),
email varchar (50)
);

create table pedido ( -- n
id int primary key,
nombre varchar (50),
precio decimal (4,2)
);

alter table pedido add constraint fkIdCliente foreign key (id) references cliente (id);
-- la tabla hija es la de mayor cardinalidad, donde va la fk
-- la tabla padre es la que tiene el atributo que será referenciado en la otra tabla

create table pedidoslinea ( -- n
idPedido int ,
idMenu int,
cantidad int,
precio decimal (4,2)
);

create table menu (
id int,
nombre varchar (50),
precio decimal (4,2)
);

alter table pedidoslinea add constraint fkPedido foreign key (idPedido) references pedido (id);
alter table menu add constraint pkMenu primary key (id);
alter table pedidoslinea add constraint fkMenu foreign key (idMenu) references menu (id);
alter table pedidoslinea add constraint pkPedidosLinea primary key (idPedido, idMenu);

create table receta (
idMenu int,
idIngrediente int,
cantidadKg int
);

alter table receta add constraint fkrecetamenu foreign key (idMenu) references menu (id);

create table ingredientes (
id int primary key,
nombre varchar (50),
precioKg decimal (4,2)
);

alter table receta add constraint fkrecetaingredientes foreign key (idIngrediente) references ingredientes (id);
alter table receta add constraint pkreceta primary key (idMenu, idIngrediente);

-- 8
create table ninio ( -- n
id int primary key,
nombre varchar (50),
apellido varchar (50),
fechaNac date,
valoracion int
);

create table direccion ( -- 1
id int primary key,
calle varchar (50),
numeroCasa int,
ciudad varchar (50),
codPostal int
);

alter table ninio add constraint fkdireccionninio foreign key (id) references direccion (id);

create table regalos ( -- n
id int primary key,
nombre varchar (50),
pesoKg int
);

create table regaloNinio (
idNinio int,
idRegalo int
);

alter table regaloNinio add constraint fkIdNinio foreign key (idNinio) references ninio (id);
alter table regaloNinio add constraint fkIdRegalo foreign key (idRegalo) references regalos (id);

alter table regaloNinio add constraint pkregaloNinio primary key (idNinio, idRegalo);