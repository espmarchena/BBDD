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

