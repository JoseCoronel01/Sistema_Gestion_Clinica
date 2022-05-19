CREATE DATABASE Clinica
GO
USE Clinica 
GO


CREATE TABLE estado
(
	Id int NOT NULL,
	Nombre varchar (40) NOT NULL,
	CONSTRAINT PK_estado PRIMARY KEY CLUSTERED (Id)
)

CREATE TABLE paciente
(
	Id bigint NOT NULL,
	ApellidoPaterno varchar (80) NOT NULL,
	ApellidoMaterno varchar (80) NOT NULL,
	Nombre varchar(80) NOT NULL,
	TelContacto varchar (10) NOT NULL,
	Responsable varchar (200) NOT NULL,
	LugarResidencia varchar (200) NOT NULL,
	Estatus char (1) NOT NULL,
	Tipo tinyint NOT NULL,
	CONSTRAINT PK_paciente PRIMARY KEY CLUSTERED (Id) 
)

CREATE TABLE usuarios
(
	Usuario varchar (15) NOT NULL,
	Password varchar (15) NOT NULL,
	Tipo char (1) NOT NULL,
	CONSTRAINT PK_usuarios PRIMARY KEY CLUSTERED (Usuario)
)

CREATE TABLE notaevolucion
(
	Id bigint NOT NULL,
	Titulo varchar (30) NOT NULL,
	Descripcion varchar (150) NOT NULL,
	Fecha datetime NOT NULL,
	Paciente bigint NOT NULL,
	Usuario varchar (15) NOT NULL,
	Estado int NOT NULL,
	CONSTRAINT PK_notaevolucion PRIMARY KEY CLUSTERED (Id),
	CONSTRAINT FK_notaevolucion_estado FOREIGN KEY (Estado) REFERENCES estado (Id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	CONSTRAINT FK_notaevolucion_paciente FOREIGN KEY (Paciente) REFERENCES paciente (Id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	CONSTRAINT FK_notaevolucion_usuario FOREIGN KEY (Usuario) REFERENCES usuarios (Usuario)
	ON UPDATE CASCADE
	ON DELETE CASCADE
)


CREATE TABLE colaboradores 
(
	Id bigint not null,
	Nombre varchar(100) not null,
	CONSTRAINT PK_colaboradores Primary Key CLUSTERED (Id)
)

CREATE TABLE colaboradoresDetalle
(
	Id bigint not null,
	ColaboradorId bigint not null,
	FechaEmision date not null,
	Importe decimal(7,2) not null,
	Pagado tinyint not null,
	FechaPago date null,
	Concepto varchar(200) null,
	CONSTRAINT PK_colaboradorDetalle PRIMARY KEY CLUSTERED (Id),
	CONSTRAINT FK_colaboradorDetalle_colaboradores FOREIGN KEY (ColaboradorId) REFERENCES colaboradores (Id)
	ON UPDATE CASCADE 
	ON DELETE CASCADE 
)
