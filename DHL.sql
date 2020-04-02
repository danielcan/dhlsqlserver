
use master 

if exists(select * from sys.databases where name='DHL')
drop database DHL

create database DHL
go

use DHL
go

create table dbo.EnvioCarga
(
	envCodigo int not null,
	envNombre varchar(100),
	envDescripcion varchar(200)
	primary key(envCodigo)
)
go

create table dbo.DetalleEnvio
(
	detCodigo int,
	detContenidoPieza varchar(200),--no se
	detFechaEnvio datetime,
	detTipoEmpaque varchar(200),--nose
	detNumeroTotalPieza int,
	detPesoTotal decimal(8,2),
	detValorDeclarado varchar(100),
	envCodigo int 
	primary key(detCodigo),
	foreign key (envCodigo) references dbo.EnvioCarga(envCodigo)
)
go

create table dbo.DatosEnvio
(
	datoCodigo int,
	datoNombre varchar(25),
	datoApellido varchar(25),
	datoEmpresa varchar(50),
	datoCargo varchar(25),
	datoCodigoPostal int,
	datoCiudad varchar(100),
	datoTelefono varchar(50),
	datoCelular varchar(50),
	datoEmail varchar(100),
	datoIdioma varchar(20),--no se
	detCodigo int
	primary key(datoCodigo) 
	foreign key(detCodigo) references dbo.DetalleEnvio (detCodigo)
)
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
	cliCodigoPostal int,
	cliCiudad varchar(80),
	cliTelefono varchar(50),
	cliCelular varchar(50),
	cliEmail varchar(100),
	cliIdioma varchar(25),
	dirCodigo int
	primary key (cliCodigo),
	foreign key (dirCodigo) references dbo.Direccion(dirCodigo)

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
	tippNumeroCuenta int
	primary key(tippCodigo)
)
go

create table dbo.ServicioAduana
(
	aduCodigo int,
	aduTransferenciaAduanal int
	primary key(aduCodigo)
)
go

create table dbo.ServicioOpcionales
(
	opcioCodigo int,
	opcioPreparacionEnvio int,
	opcioProtecionEnvio int
	primary key(opcioCodigo) 
)
go

create table dbo.Factura
(
	facCodigo int,
	facTerminoPago varchar(100),
	facRazoExportacion varchar(200),
	facFechaFactura datetime,
	tippCodigo int,
	paqCodigo int,
	cliCodigo int,
	tipCodigo int,
	opcioCodigo int,
	aduCodigo int,
	datoCodigo int
	primary key(facCodigo),
	foreign key(tippCodigo) references dbo.TipoPago(tippCodigo),
	foreign key(paqCodigo) references dbo.Paquete(paqCodigo),
	foreign key(cliCodigo) references dbo.Cliente(cliCodigo),
	foreign key(tipCodigo) references dbo.TipoServicio(tipCodigo),
	foreign key(opcioCodigo) references dbo.ServicioOpcionales(opcioCodigo),
	foreign key(aduCodigo) references dbo.ServicioAduana(aduCodigo),
	foreign key(datoCodigo) references dbo.DatosEnvio(datoCodigo)
)
go


create table dbo.Cracking 
(
	craCodigo int,
	dirCodigo int,
	paqCodigo int
	primary key(craCodigo)
)
go




--proceso de insertar datos a la s tablas de sql
create procedure sp_iEnvioCarga
	@envCodigo int,
	@envNombre varchar(100),
	@envDescripcion varchar(200)
	as insert into dbo.EnvioCarga 
	(envCodigo,envNombre,envDescripcion)
	values
	(@envCodigo,@envNombre,@envDescripcion)
	go


create procedure sp_iDetalleEnvio
	@detCodigo int,
	@detContenidoPieza varchar(200),--no se
	@detFechaEnvio datetime,
	@detTipoEmpaque varchar(200),--nose
	@detNumeroTotalPieza int,
	@detPesoTotal decimal(8,2),
	@detValorDeclarado varchar(100),
	@envCodigo int 
	as insert into dbo.DetalleEnvio
	(detCodigo,detContenidoPieza,detFechaEnvio,detTipoEmpaque,detNumeroTotalPieza,detPesoTotal,detValorDeclarado,envCodigo)
	values
	(@detCodigo,@detContenidoPieza,@detFechaEnvio,@detTipoEmpaque,@detNumeroTotalPieza,@detPesoTotal,@detValorDeclarado,@envCodigo)
	go


create procedure sp_iDatosEnvio	
	@datoCodigo int,
	@datoNombre varchar(25),
	@datoApellido varchar(25),
	@datoEmpresa varchar(50),
	@datoCargo varchar(25),
	@datoCodigoPostal int,
	@datoCiudad varchar(100),
	@datoTelefono varchar(50),
	@datoCelular varchar(50),
	@datoEmail varchar(100),
	@datoIdioma varchar(20),--no se
	@detCodigo int
	as insert into dbo.DatosEnvio
	(datoCodigo,datoNombre ,datoApellido,datoEmpresa,datoCargo,
	datoCodigoPostal,datoCiudad,datoTelefono,datoCelular,datoEmail,datoIdioma,detCodigo)
	values
	(@datoCodigo,@datoNombre ,@datoApellido,@datoEmpresa,@datoCargo,
	@datoCodigoPostal,@datoCiudad,@datoTelefono,@datoCelular,@datoEmail,@datoIdioma,@detCodigo)
	go

	create procedure sp_iDireccion
	@dirCodigo int,
	@dirDireccion1 varchar(200),
	@dirDireccion2 varchar(200),
	@dirDireccion3 varchar(200)
	as insert into dbo.Direccion
	(dirCodigo,dirDireccion1,dirDireccion2,dirDireccion3)
	values
	(@dirCodigo,@dirDireccion1,@dirDireccion2,@dirDireccion3)
	go

	create procedure sp_iCliente
	@cliCodigo int,
	@cliNombre varchar(45),
	@cliApellido varchar(45),
	@cliEmpresa varchar(100),
	@cliCargo varchar(45),
	@cliCodigoPostal int,
	@cliCiudad varchar(80),
	@cliTelefono varchar(50),
	@cliCelular varchar(50),
	@cliEmail varchar(100),
	@cliIdioma varchar(25),
	@dirCodigo int
	as insert into dbo.Cliente
	(cliCodigo,cliNombre,cliApellido,cliEmpresa,cliCargo,cliCodigoPostal,cliCiudad,cliTelefono,cliCelular,cliEmail,cliIdioma,dirCodigo)
	values
	(@cliCodigo,@cliNombre,@cliApellido,@cliEmpresa,@cliCargo,@cliCodigoPostal,@cliCiudad,@cliTelefono,@cliCelular,@cliEmail,@cliIdioma,@dirCodigo)
	go

	create procedure sp_iTipoServicio
	@tipCodigo int,
	@tipNombre varchar(45)
	as insert into dbo.TipoServicio
	(tipCodigo,tipNombre)
	values
	(@tipCodigo,@tipNombre)
	go

	create procedure sp_iPaquete
	@paqCodigo int,
	@paqPieza int,
	@paqPeso decimal(20),	
	@paqLargo decimal(20),
	@paqAncho decimal(20),
	@paqAlto decimal(20),
	@paqDescripcion varchar(100)
	as insert into dbo.Paquete
	(paqCodigo,paqPieza,paqPeso,paqLargo,paqAncho,paqAlto,paqDescripcion)
	values
	(@paqCodigo,@paqPieza,@paqPeso,@paqLargo,@paqAncho,@paqAlto,@paqDescripcion)
	go


	create procedure sp_iTipoPago
    @tippCodigo int,
	@tippNombre varchar(100),
	@tippNumeroCuenta int
	as insert into dbo.TipoPago
	(tippCodigo,tippNombre,tippNumeroCuenta)
	values
	(@tippCodigo,@tippNombre,@tippNumeroCuenta)
	go

	create  procedure sp_iServicioAduana
	@aduCodigo int,
	@aduTransferenciaAduanal int
	as insert into dbo.ServicioAduana
	(aduCodigo,aduTransferenciaAduanal)
	values
	(@aduCodigo,@aduTransferenciaAduanal)
	go

	create procedure sp_iServicioOpcionales
	@opcioCodigo int,
	@opcioPreparacionEnvio int,
	@opcioProtecionEnvio int
	as insert into dbo.ServicioOpcionales
	(opcioCodigo,opcioPreparacionEnvio,opcioProtecionEnvio)
	values
	(@opcioCodigo,@opcioPreparacionEnvio,@opcioProtecionEnvio)
	go

	create procedure sp_iFactura
	@facCodigo int,
	@facTerminoPago varchar(100),
	@facRazoExportacion varchar(200),
	@facFechaFactura datetime,
	@tippCodigo int,
	@paqCodigo int,
	@cliCodigo int,
	@tipCodigo int,
	@opcioCodigo int,
	@aduCodigo int,
	@datoCodigo int
	as insert into dbo.Factura
	(facCodigo,
	facTerminoPago,
	facRazoExportacion,
	facFechaFactura,
	tippCodigo,
	paqCodigo,cliCodigo,tipCodigo,opcioCodigo,
	aduCodigo,datoCodigo)
	values
	(@facCodigo,
	@facTerminoPago,
	@facRazoExportacion,
	@facFechaFactura,
	@tippCodigo,
	@paqCodigo,@cliCodigo,@tipCodigo,@opcioCodigo,@aduCodigo,@datoCodigo)
	go

	create procedure sp_iCracking
	@craCodigo int,
	@dirCodigo int,
	@paqCodigo int
	as insert into dbo.Cracking
	(craCodigo,dirCodigo,paqCodigo)
	values
	(@craCodigo,@dirCodigo,@paqCodigo)
	go

	--proceso de la eliminacion de tablas en sql
	create procedure sp_dEnvioCarga
	@envCodigo int
	as delete from dbo.EnvioCarga
	where envCodigo = @envCodigo
	go

	create procedure sp_dDetalleEnvio
	@detCodigo int
	as delete from dbo.DetalleEnvio
	where detCodigo = @detCodigo
	go

	create procedure sp_dDatosEnvio
	@datoCodigo int 
	as delete from dbo.DatosEnvio
	where datoCodigo = @datoCodigo
	go

	create procedure sp_dDireccion
	@dirCodigo int
	as delete from dbo.Direccion
	where dirCodigo = @dirCodigo
	go

	create procedure sp_dCliente
	@cliCodigo int
	as delete from dbo.Cliente
	where cliCodigo = @cliCodigo
	go

	create procedure sp_dTipoServicio
	@tipCodigo int
	as delete from dbo.TipoServicio
	where tipCodigo = @tipCodigo
	go

	create procedure sp_dPaquete
	@paqCodigo int
	as delete from dbo.Paquete
	where paqCodigo = @paqCodigo
	go

	create procedure sp_dTipoPago
	@tippCodigo int
	as delete from dbo.TipoPago
	where tippCodigo = @tippCodigo
	go

	create procedure sp_dServicioAduana
	@aduCodigo int 
	as delete from dbo.ServicioAduana
	where aduCodigo = @aduCodigo
	go


	create procedure sp_dServicioOpcionales
	@opcioCodigo int
	as delete from dbo.ServicioOpcionales
	where opcioCodigo = @opcioCodigo
	go

	create procedure sp_dFactura
	@facCodigo int
	as delete from dbo.Factura
	where facCodigo = @facCodigo
	go

	create procedure sp_dCracking
	@craCodigo int
	as delete from dbo.Cracking
	where craCodigo = @craCodigo
	go




	--procesos de actualizaciones
	create procedure sp_uEnvioCarga
	@envCodigo int,
	@envNombre varchar(100),
	@envDescripcion varchar(200)
	as update dbo.EnvioCarga set
    envNombre = @envNombre,
	envDescripcion = @envDescripcion
	where envCodigo = @envCodigo
	go 

	create procedure sp_uDetalleEnvio
	@detCodigo int,
	@detContenidoPieza varchar(200),
	@detFechaEnvio datetime,
	@detTipoEmpaque varchar(200),
	@detNumeroTotalPieza int,
	@detPesoTotal decimal(8,2),
	@detValorDeclarado varchar(100),
	@envCodigo int 
	as update dbo.DetalleEnvio set
	detContenidoPieza = @detContenidoPieza,
	detFechaEnvio = @detFechaEnvio,
	detTipoEmpaque = @detTipoEmpaque,
	detNumeroTotalPieza = @detNumeroTotalPieza,
	detPesoTotal = @detPesoTotal,
	detValorDeclarado = @detValorDeclarado,
	envCodigo = @envCodigo
	where detCodigo = @detCodigo
	go

	create procedure sp_uDatosEnvio
	@datoCodigo int,
	@datoNombre varchar(25),
	@datoApellido varchar(25),
	@datoEmpresa varchar(50),
	@datoCargo varchar(25),
	@datoCodigoPostal int,
	@datoCiudad varchar(100),
	@datoTelefono varchar(50),
	@datoCelular varchar(50),
	@datoEmail varchar(100),
	@datoIdioma varchar(20),
	@detCodigo int
	as update dbo.DatosEnvio set
	datoNombre=@datoNombre,
	datoApellido=@datoApellido,
	datoEmpresa=@datoEmpresa,
	datoCargo=@datoCargo ,
	datoCodigoPostal=@datoCodigoPostal,
	datoCiudad=@datoCiudad,
	datoTelefono=@datoTelefono,
	datoCelular=@datoCelular,
	datoEmail=@datoEmail,
	datoIdioma=@datoIdioma,
	detCodigo=@detCodigo 
	where datoCodigo = @detCodigo
	go


	create procedure sp_uDireccion
	@dirCodigo int,
	@dirDireccion1 varchar(200),
	@dirDireccion2 varchar(200),
	@dirDireccion3 varchar(200)
	as update dbo.Direccion set
	dirDireccion1=@dirDireccion1,
	dirDireccion2=@dirDireccion2,
	dirDireccion3=@dirDireccion3
	where dirCodigo = @dirCodigo
	go

	create procedure sp_uCliente
	@cliCodigo int,
	@cliNombre varchar(45),
	@cliApellido varchar(45),
	@cliEmpresa varchar(100),
	@cliCargo varchar(45),
	@cliCodigoPostal int,
	@cliCiudad varchar(80),
	@cliTelefono varchar(50),
	@cliCelular varchar(50),
	@cliEmail varchar(100),
	@cliIdioma varchar(25),
	@dirCodigo int
	as update dbo.Cliente set
	cliNombre=@cliNombre,
	cliApellido=@cliApellido,
	cliEmpresa=@cliEmpresa,
	cliCargo=@cliCargo,
	cliCodigoPostal=@cliCodigoPostal,
	cliCiudad=@cliCiudad,
	cliTelefono=@cliTelefono,
	cliCelular=@cliCelular,
	cliEmail=@cliEmail,
	cliIdioma=@cliIdioma,
	dirCodigo=@dirCodigo
	where cliCodigo = @cliCodigo
	go

	create procedure sp_uTipoServicio
	@tipCodigo int,
	@tipNombre varchar(45)
	as update dbo.TipoServicio set
	tipNombre = @tipNombre
	where tipCodigo = @tipCodigo
	go

	create procedure sp_uPaquete
	@paqCodigo int,
	@paqPieza int,
	@paqPeso decimal(20),	
	@paqLargo decimal(20),
	@paqAncho decimal(20),
	@paqAlto decimal(20),
	@paqDescripcion varchar(100)
	as update dbo.Paquete set
	paqPieza=@paqPieza,
	paqPeso=@paqPeso ,	
	paqLargo=@paqLargo ,
	paqAncho=@paqAncho,
	paqAlto=@paqAlto,
	paqDescripcion=@paqDescripcion
	where paqCodigo = @paqCodigo
	go

	create procedure sp_uTipoPago
	@tippCodigo int,
	@tippNombre varchar(100),
	@tippNumeroCuenta int
	as update dbo.TipoPago set
	tippNombre=@tippNombre,
	tippNumeroCuenta=@tippNumeroCuenta
	where tippCodigo = @tippCodigo
	go

	create procedure sp_uServicioAduana
	@aduCodigo int,
	@aduTransferenciaAduanal int
	as update dbo.ServicioAduana set
	aduTransferenciaAduanal = @aduTransferenciaAduanal
	where aduCodigo = @aduCodigo
	go

	create procedure sp_uServicioOpcionales
	@opcioCodigo int,
	@opcioPreparacionEnvio int,
	@opcioProtecionEnvio int
	as update dbo.ServicioOpcionales set
	opcioPreparacionEnvio=@opcioPreparacionEnvio,
	opcioProtecionEnvio=@opcioProtecionEnvio
	where opcioCodigo = @opcioCodigo
	go

	create procedure sp_uFactura
	@facCodigo int,
	@facTerminoPago varchar(100),
	@facRazoExportacion varchar(200),
	@facFechaFactura datetime,
	@tippCodigo int,
	@paqCodigo int,
	@cliCodigo int,
	@tipCodigo int,
	@opcioCodigo int,
	@aduCodigo int,
	@datoCodigo int
	as update dbo.Factura set
	facTerminoPago=@facTerminoPago,
	facRazoExportacion=@facRazoExportacion,
	facFechaFactura=@facFechaFactura,
	tippCodigo=@tippCodigo,
	paqCodigo=@paqCodigo,
	cliCodigo=@cliCodigo,
	tipCodigo=@tipCodigo,
	opcioCodigo=@opcioCodigo,
	aduCodigo=@aduCodigo,
	datoCodigo=@datoCodigo
	where facCodigo=@facCodigo
	go
	

	--mostrar
	create procedure sp_sEnvioCarga
	as select * from dbo.EnvioCarga order by envCodigo desc 
	go

	create procedure sp_sDetalleEnvio
	as select * from dbo.DetalleEnvio order by detCodigo desc
	go

	create procedure sp_sDatosEnvio
	as select * from dbo.DatosEnvio order by datoCodigo desc
	go

	create procedure sp_sDireccion
	as select * from dbo.Direccion order by dirCodigo desc
	go

	create procedure sp_sCliente
	as select * from dbo.Cliente order by cliCodigo desc 
	go

	create procedure sp_sTipoServicio
	as select * from dbo.TipoServicio order by tipCodigo desc
	go

	create procedure sp_sPaquete
	as select * from dbo.Paquete order by paqCodigo desc
	go

	create procedure sp_sTipoPago
	as select * from dbo.TipoPago order by tippCodigo desc
	go

	create procedure sp_sServicioAduana
	as select * from dbo.ServicioAduana order by aduCodigo desc
	go

	create procedure sp_sServicioOpcionales
	as select * from dbo.ServicioOpcionales order by opcioCodigo desc
	go

	create procedure sp_sCracking
	as select * from dbo.Cracking order by craCodigo desc
	go

	create procedure sp_sFactura
	as select * from dbo.Factura order by facCodigo desc 
	go


	exec sp_iEnvioCarga '1','Avion','Grande'
	exec sp_iEnvioCarga '2','camion','Grande'
	exec sp_iEnvioCarga '3','busito','Pequeño'

	exec sp_iDetalleEnvio '1','5','12/04/2019','grande','25','25.23','Valor Declarado','1'
	exec sp_iDetalleEnvio '2','3','12/03/2019','grande','24','27.23','No Valor Declarado','2'
	exec sp_iDetalleEnvio '3','4','12/02/2019','pequeño','23','26.23','Valor Declarado','3'

	exec sp_iDatosEnvio '1','carlos','pancho','Unitec','Tecnico','4587','Tegucigalpa','23124564','98789763','carlos@unitec','Español','1'
	exec sp_iDatosEnvio '2','daniel','martinez','Unitec','Tecnico','3587','Tegucigalpa','25924564','989879763','daniel@unitec','Español','2'
	exec sp_iDatosEnvio '3','maria','carcamo','Unitec','Tecnico','4873','Tegucigalpa','23244564','98786883','caos@unitec','Español','3'

	exec sp_iDireccion '1','21 de octubre','sitio','chimbo'
	exec sp_iDireccion '2','kenedy','chimbo','chimbo'
	exec sp_iDireccion '3','el centro','sitio','residencial'

	exec sp_iCliente '1','jose','carbajal','ceutec','tecnico','5648','tegucigalpa','245646','98732','jose@ceutce','español','1'
	exec sp_iCliente '2','maria','rodriguez','ceutec','tecnico','6648','tegucigalpa','2432346','88732','se@ceutce','español','2'
	exec sp_iCliente '3','adonay','canales','ceutec','tecnico','7648','tegucigalpa','145646','78732','e@ceutce','español','3'

	exec sp_iTipoServicio '1','Servicio de Exportacion'
	exec sp_iTipoServicio '2','Servicio de importacion'
	exec sp_iTipoServicio '3','Servicio de Internacional'


	exec sp_iPaquete '1','2','12','65','32','50','grande'
	exec sp_iPaquete '2','4','22','55','12','40','componentes delicados'
	exec sp_iPaquete '3','6','32','45','62','30','componentes delicados grandes'

	exec sp_iTipoPago '1','tarjeta de credito','156463258'
	exec sp_iTipoPago '2','cuenta bancaria','356879789'
	exec sp_iTipoPago '3','efecivo','26463258'

	exec sp_iServicioAduana '1','25'
	exec sp_iServicioAduana '2','55'
	exec sp_iServicioAduana '3','75'

	exec sp_iServicioOpcionales '1','94','25'
	exec sp_iServicioOpcionales '2','85','55'
	exec sp_iServicioOpcionales '3','75','95'

	exec sp_iFactura '1','primordial','rapido','12/03/2019','1','1','1','1','1','1','1'
	exec sp_iFactura '2','primordial','rapido','12/03/2019','2','2','2','2','2','2','2'
	exec sp_iFactura '3','primordial','rapido','12/03/2019','3','3','3','3','3','3','3'

	exec sp_iCracking '1','1','1'
	exec sp_iCracking '2','2','2'
	exec sp_iCracking '3','3','3'
