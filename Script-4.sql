create database dptouniversitario2;

create table datospersonales(
secuencia int,
nombre varchar(10),
primerapellido varchar(10),
segundoapellido varchar(10)
);

create table doctor(
secuencia int,
fechacomienzo date
);

create table doctorando(
secuencia int primary key,
titulo varchar(10),
calificacion numeric
);

create table departamento(
codigodpto int primary key,
descripcion varchar(50),
numprofesor numeric,
secuencia int
);

alter table datospersonales add column codigodpto int; -- añado el atributo codigodpto en la tabla datospersonales porque cuando la hice aun no existia la tabla departamento pa poderle hacer la fk y relacionarla directamente --

alter table datospersonales add constraint fkcodigodptodatospersonales foreign key (codigodpto) references departamento(codigodpto);


alter table doctor add constraint fksecuenciadoctor foreign key (secuencia) references datospersonales(secuencia);  -- xx -- 
alter table doctorando add constraint fksecuenciadoctorando foreign key (secuencia) references datospersonales(secuencia);
alter table departamento add constraint fksecuenciadpto foreign key (secuencia) references datospersonales(secuencia);

alter table datospersonales add constraint pkdatospersonales primary key (secuencia,codigodpto);



CONSTRAINT nombredelafk FOREIGN KEY (atributodelamismatabla) REFERENCES 
tablaAlaQueValaFK(atributoDeLaOtraTabla)