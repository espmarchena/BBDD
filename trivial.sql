create database trivial;
use trivial;
 
create table jugador(
id numeric,
nombre varchar(10),
color varchar(10)
);
 
create table categoria(
id numeric,
nombre varchar(10),
color varchar(10),
categoria varchar(10)
);

alter table jugador add constraint pkjugador primary key (id);
alter table categoria add constraint pkcategoria primary key (id);
 
create table tarjeta(
id numeric,
pregunta varchar(100),
respuesta varchar(100),
descripcion varchar(100)
);

alter table tarjeta add constraint pk_idtarjeta primary key (id);
alter table tarjeta add constraint fk_idtarjeta foreign key (id) references categoria(id);

create table tarjetajugador (
id numeric primary key,
id_tarjeta numeric not null,
id_jugador numeric not null,
acierto boolean,
quesito boolean,
respuesta varchar(100)
);

alter table tarjetajugador add constraint fk_tarjuga foreign key (id_tarjeta) references tarjeta (id);
alter table tarjetajugador add constraint fk_jugatar foreign key (id_jugador) references jugador (id);

alter table jugador modify nombre varchar(3);
alter table jugador add email varchar(100) not null;
alter table jugador drop email;
alter table jugador add email varchar(100);
alter table tarjeta drop constraint fk_idtarjeta;
alter table categoria drop constraint primary key;
alter table categoria add constraint pkcategoria primary key(id);
alter table tarjeta add constraint fk_tarjeta foreign key (id) references categoria (id);