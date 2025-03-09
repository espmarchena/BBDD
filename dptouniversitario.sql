create database dptouniversitario;

create table datospersonales(
secuencia int primary key,
nombre varchar(10),
primerapellido varchar(10),
segundoapellido varchar(10)
);

create table doctor(
secuencia int primary key,
fechacomienzo date,
constraint fksecuenciadoctor foreign key (secuencia) references datospersonales(secuencia) 
);

create table doctorando(
secuencia int primary key,
titulo varchar(10),
calificacion numeric,
constraint fksecuenciadoctorando foreign key (secuencia) references datospersonales(secuencia) 
);

create table departamento(
codigodpto int primary key,
descripcion varchar(50),
numprofesor numeric,
secuencia int,
constraint fksecuenciadpto foreign key (secuencia) references datospersonales(secuencia) 
);

alter table datospersonales add column codigodpto int; -- añado el atributo codigodpto en la tabla datospersonales porque cuando la hice aun no existia la tabla departamento pa poderle hacer la fk y relacionarla directamente --

alter table datospersonales add constraint fkcodigodptodatospersonales foreign key (codigodpto) references departamento(codigodpto); --  -- 

alter table datospersonales add constraint pkdatospersonales primary key (secuencia,codigodpto);



CONSTRAINT nombredelafk FOREIGN KEY (atributodelamismatabla) REFERENCES 
tablaAlaQueValaFK(atributoDeLaOtraTabla)