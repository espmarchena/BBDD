create database pruebaevaluable;

use pruebaevaluable;

create table datospersonales(
secuencia int,
cod_dep numeric,
nombre varchar(10),
pr_apellido varchar(10),
sg_apellido varchar(10)
);

create table departamento( 
cod_dep numeric,
despripcion varchar(10),
num_prof numeric
);

create table doctorando (
secuencia int,
cod_dep numeric, 
fecha_comienzo numeric
);

create table doctor (
secuencia int,
cod_dep numeric, 
titulo varchar(10),
calificacion numeric
);

create table curso (
cod_curso numeric, 
num_horas numeric,
lugar varchar(10)
);

create table doctorando_curso (
cod_curso numeric,
secuencia int,
cod_dep numeric
);

create table doctor_curso (
cod_curso numeric,
secuencia int,
cod_dep numeric,
fecha numeric
);

create table articulo (
cod_art numeric,
titulo varchar(10),
num_pag numeric
);

create table doctorando_art (
secuencia int,
cod_dep numeric,
cod_art numeric
);

create table idioma(
idioma varchar(10)
);

create table idioma_art (
idioma varchar(10),
cod_art numeric
);

create table actividad (
cod_act numeric,
despripcion varchar(10),
tipo varchar(10)
);

create table actividad_act (
cod_art numeric,
cod_act numeric
);


alter table departamento add constraint pkdepartamento primary key (cod_dep);
alter table datospersonales add constraint pkdatospersonales primary key (secuencia, cod_dep); 

alter table doctorando add constraint fkcoddep foreign key (secuencia, cod_dep) references datospersonales(secuencia, cod_dep); 
alter table doctor add constraint fkcoddepdoctor foreign key (secuencia, cod_dep) references datospersonales(secuencia, cod_dep); 

alter table datospersonales add constraint fkdatospersonales foreign key (cod_dep) references departamento(cod_dep);

alter table doctorando add constraint pksecuenciadoctorando primary key (secuencia, cod_dep);
alter table doctor add constraint pksecuenciadoctor primary key (secuencia,cod_dep);

alter table curso add constraint pkcurso primary key (cod_curso);
alter table doctorando_curso add constraint fkdoctorandocurso_curso foreign key (secuencia,cod_dep) references doctorando(secuencia,cod_dep);
alter table doctorando_curso add constraint fkcod_curso foreign key (cod_curso) references curso(cod_curso);
alter table doctorando_curso add constraint primary key (secuencia, cod_dep, cod_curso);

alter table doctor_curso add constraint fkdoctorcurso_curso foreign key (secuencia,cod_dep) references doctor(secuencia,cod_dep);
alter table doctor_curso add constraint fkcod_curso_doctor foreign key (cod_curso) references curso(cod_curso);
alter table doctor_curso add constraint primary key (secuencia, cod_dep, cod_curso);

alter table articulo add constraint pkarticulo primary key (cod_art);
alter table articulo add column doctor numeric;
alter table articulo modify doctor int; 
alter table articulo add constraint fkdoctor foreign key (doctor, cod_art) references doctor(secuencia,cod_dep); 

alter table doctorando_art add constraint fkdoctorando_art foreign key (secuencia,cod_dep) references doctorando(secuencia,cod_dep);
alter table doctorando_art add constraint fkdoctorando_art_articulo foreign key (cod_art) references articulo(cod_art);
alter table doctorando_art add constraint pkdoctorando_art primary key (secuencia, cod_dep, cod_art);

alter table idioma add constraint pkidioma primary key (idioma);
alter table idioma_art add constraint fkidioma_art foreign key (idioma) references idioma(idioma);
alter table idioma_art add constraint fkidioma_art_ foreign key (cod_art) references articulo(cod_art);
alter table idioma_art add constraint pkidioma_art primary key (idioma,cod_art);

alter table actividad add constraint pkactividad primary key (cod_act);
alter table actividad_act add constraint fkactividad_act foreign key (cod_art) references articulo(cod_art);
alter table actividad_act add constraint fkactividad_act_ foreign key (cod_act) references actividad(cod_act);
alter table actividad_act add constraint pkactividad_act primary key (cod_art,cod_act);
