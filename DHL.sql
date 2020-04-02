use master

if exists (select * from sys.databases where name='DHL')
drop database DHL

create database DHL
go

use DHL
go 


create table dbo.Direccion
(
	dirCodigo int not null,
	dirDireccion1 varchar(200),
	dirDireccion2 varchar(200),
	dirDireccion3 varchar(200)
	primary key (dirCodigo)
)
go



create table dbo.Cliente
(
	cliCodigo int,
	cliNombre varchar(45),
	cliApellido varchar(45),
	cliEmpresa varchar(100),
	cliCargo varchar(45),
	cliCodigo_postal int,
	cliCiudad varchar(80),
	cliTelefono varchar(50),
	cliCelular varchar(50),
	cliEmail varchar(100),
	cliIdioma varchar(25),
	coddir int
	primary key (cliCodigo),
	foreign key (coddir) references dbo.Direccion(dirCodigo)

)
go


create table dbo.TipoServicio
(
	tipCodigo int not null,
	tipNombre varchar(45)
	primary key (tipCodigo)
)
go

create table dbo.Paquete
(
	paqCodigo int,
	paqPieza int,
	paqPeso decimal(20),--no se	
	paqLargo decimal(20),--nose 
	paqAncho decimal(20),--nose 
	paqAlto decimal(20),--no se
	paqDescripcion varchar(100)
	primary key(paqCodigo)
)
go

create table dbo.TipoPago
(
	tippCodigo int,
	tippNombre varchar(100),
	tippNumeroCuenta int,
	primary key(tippCodigo)
)
go

create table dbo.DetalleEnvio
(
	detCodigo int not null,
	detContenidoPieza varchar(200),
	detFechaEnvio datetime,
	detTipoEmpaque varchar(100),
	detNumeroTotalPieza int,
	detPesoTotal decimal(20),
	primary key(detCodigo)
)
go

create table dbo.DatosEnvio
(
	
)
go