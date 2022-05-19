--SQLServer 2019  18.11.1
CREATE DATABASE Clinica;
GO

USE [Clinica]
GO

/****** Object:  Table [dbo].[colaboradores]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[colaboradores](
	[Id] [bigint] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK_colaboradores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[colaboradoresDetalle]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[colaboradoresDetalle](
	[Id] [bigint] NOT NULL,
	[ColaboradorId] [bigint] NOT NULL,
	[FechaEmision] [date] NOT NULL,
	[Importe] [decimal](7, 2) NOT NULL,
	[Pagado] [tinyint] NOT NULL,
	[FechaPago] [date] NULL,
	[Concepto] [varchar](200) NULL,
 CONSTRAINT [PK_colaboradorDetalle] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[estado]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estado](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](40) NOT NULL,
 CONSTRAINT [PK_estado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[notaevolucion]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notaevolucion](
	[Id] [bigint] NOT NULL,
	[Titulo] [varchar](30) NOT NULL,
	[Descripcion] [varchar](150) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Paciente] [bigint] NOT NULL,
	[Usuario] [varchar](15) NOT NULL,
	[Estado] [int] NOT NULL,
 CONSTRAINT [PK_notaevolucion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[paciente]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[paciente](
	[Id] [bigint] NOT NULL,
	[ApellidoPaterno] [varchar](80) NOT NULL,
	[ApellidoMaterno] [varchar](80) NOT NULL,
	[Nombre] [varchar](80) NOT NULL,
	[TelContacto] [varchar](10) NOT NULL,
	[Responsable] [varchar](200) NOT NULL,
	[LugarResidencia] [varchar](200) NOT NULL,
	[Estatus] [char](1) NOT NULL,
	[Tipo] [tinyint] NOT NULL,
 CONSTRAINT [PK_paciente] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipotratamiento]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipotratamiento](
	[Id] [tinyint] NOT NULL,
	[Nombre] [varchar](40) NOT NULL,
 CONSTRAINT [PK_tipotratamiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuarios](
	[Usuario] [varchar](15) NOT NULL,
	[Password] [varchar](15) NOT NULL,
	[Tipo] [char](1) NOT NULL,
 CONSTRAINT [PK_usuarios] PRIMARY KEY CLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[colaboradoresDetalle]  WITH CHECK ADD  CONSTRAINT [FK_colaboradorDetalle_colaboradores] FOREIGN KEY([ColaboradorId])
REFERENCES [dbo].[colaboradores] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[colaboradoresDetalle] CHECK CONSTRAINT [FK_colaboradorDetalle_colaboradores]
GO
ALTER TABLE [dbo].[notaevolucion]  WITH CHECK ADD  CONSTRAINT [FK_notaevolucion_estado] FOREIGN KEY([Estado])
REFERENCES [dbo].[estado] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[notaevolucion] CHECK CONSTRAINT [FK_notaevolucion_estado]
GO
ALTER TABLE [dbo].[notaevolucion]  WITH CHECK ADD  CONSTRAINT [FK_notaevolucion_paciente] FOREIGN KEY([Paciente])
REFERENCES [dbo].[paciente] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[notaevolucion] CHECK CONSTRAINT [FK_notaevolucion_paciente]
GO
ALTER TABLE [dbo].[notaevolucion]  WITH CHECK ADD  CONSTRAINT [FK_notaevolucion_usuario] FOREIGN KEY([Usuario])
REFERENCES [dbo].[usuarios] ([Usuario])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[notaevolucion] CHECK CONSTRAINT [FK_notaevolucion_usuario]
GO
ALTER TABLE [dbo].[paciente]  WITH CHECK ADD  CONSTRAINT [FK_paciente_tipotratamiento] FOREIGN KEY([Tipo])
REFERENCES [dbo].[tipotratamiento] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[paciente] CHECK CONSTRAINT [FK_paciente_tipotratamiento]
GO
/****** Object:  StoredProcedure [dbo].[AccesoAlSistema]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Acceso al sistema, recibe como parametro el usuario y el password y si existe regresa el usuario y el tipo de usuario.
-- =============================================
CREATE PROCEDURE [dbo].[AccesoAlSistema]
@Usuario varchar(15),
@Password varchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Usuario, Tipo FROM usuarios 
	WHERE Usuario = @Usuario 
	AND Password = @Password 

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[BusquedaColaborador]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Buscar colaboradores 
-- =============================================
CREATE PROCEDURE [dbo].[BusquedaColaborador]
@Nombre varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.Id,a.Nombre,b.Id as Detalle,b.FechaEmision,b.Importe,b.Pagado,b.FechaPago,b.Concepto
	FROM colaboradores a 
	INNER JOIN colaboradoresDetalle b ON b.ColaboradorId=a.Id
	WHERE a.Nombre=@Nombre
	ORDER BY b.FechaEmision DESC
END
GO
/****** Object:  StoredProcedure [dbo].[BusquedaNotaEvolucion]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Buscar la nota de evolución
-- =============================================
CREATE PROCEDURE [dbo].[BusquedaNotaEvolucion]
@Titulo varchar(30),
@Fecha datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id,Titulo,Descripcion,Fecha,Paciente,Usuario,Estado 
	FROM notaevolucion 
	WHERE Titulo=@Titulo OR Convert(date, Fecha)=Convert(date, @Fecha) 

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[BusquedaPaciente]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Buscar al paciente 
-- =============================================
CREATE PROCEDURE [dbo].[BusquedaPaciente]
@ApellidoPaterno varchar(80),
@ApellidoMaterno varchar(80),
@Nombre varchar(80),
@TelContacto varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id,ApellidoPaterno,ApellidoMaterno,Nombre,TelContacto,Responsable,LugarResidencia,Estatus,Tipo 
	FROM paciente 
	WHERE ApellidoPaterno=@ApellidoPaterno OR ApellidoMaterno=@ApellidoMaterno OR Nombre=@Nombre
	OR TelContacto=@TelContacto

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[CatColaboradorDetalle]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Catalogo de Colaborador detalle, se inserta un registro y se actualiza el mismo.
-- =============================================
CREATE PROCEDURE [dbo].[CatColaboradorDetalle]
@Id bigint,
@ColaboradorId bigint,
@FechaEmision date,
@Importe decimal(7,2),
@Pagado tinyint,
@FechaPago date null,
@Concepto varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT Id FROM colaboradoresDetalle WHERE Id=@Id)
	BEGIN
		INSERT INTO colaboradoresDetalle (Id,ColaboradorId,FechaEmision,Importe,Pagado,FechaPago,Concepto) 
		VALUES (@Id,@ColaboradorId,@FechaEmision,@Importe,@Pagado,@FechaPago,@Concepto)
	END
	ELSE
	BEGIN
		UPDATE colaboradoresDetalle SET ColaboradorId=@ColaboradorId,FechaEmision=@FechaEmision,Importe=@Importe,Pagado=@Pagado,FechaPago=@FechaPago,Concepto=@Concepto
		WHERE Id=@Id
	END
	SELECT 1 AS Guardado

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[CatColaboradorMaestro]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Catalogo de colaboradores 
-- =============================================
CREATE PROCEDURE [dbo].[CatColaboradorMaestro]
@Id bigint,
@Nombre varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT Id FROM colaboradores WHERE Id=@Id)
	BEGIN
		INSERT INTO colaboradores (Id,Nombre) VALUES (@Id,@Nombre)
	END
	ELSE
	BEGIN
		UPDATE colaboradores SET Nombre=@Nombre WHERE Id=@Id
	END
	SELECT 1 AS Guardado

	SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[CatNotaEvolucion]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Catalogo de Notas de evolución, se inserta un registro nuevo y se actualiza el ya existente.
-- =============================================
CREATE PROCEDURE [dbo].[CatNotaEvolucion]
@Id bigint,
@Titulo varchar(30),
@Descripcion varchar (150),
@Fecha datetime,
@Paciente bigint,
@Usuario varchar(15),
@Estado int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF NOT EXISTS (SELECT Id FROM notaevolucion WHERE Id=@Id)
	BEGIN
		INSERT INTO notaevolucion (Id,Titulo,Descripcion,Fecha,Paciente,Usuario,Estado) 
		VALUES (@Id,@Titulo,@Descripcion,@Fecha,@Paciente,@Usuario,@Estado)
	END
	ELSE
	BEGIN
		UPDATE notaevolucion SET Titulo=@Titulo,Descripcion=@Descripcion,Fecha=@Fecha,Paciente=@Paciente,Usuario=@Usuario,Estado=@Estado
		WHERE Id=@Id
	END
	SELECT 1 AS Guardado

	SET NOCOUNT OFF;

END
GO
/****** Object:  StoredProcedure [dbo].[CatPacientes]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Catalogo de Pacientes, dar de alta un paciente y actualizar su registro.
-- =============================================
CREATE PROCEDURE [dbo].[CatPacientes]
@Id bigint,
@ApellidoPaterno varchar(80),
@ApellidoMaterno varchar(80),
@Nombre varchar(80),
@TelContacto varchar(10),
@Responsable varchar(200),
@LugarResidencia varchar(200),
@Estatus char(1),
@Tipo tinyint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF Not Exists (SELECT Id FROM paciente WHERE Id=@Id)
	BEGIN
		INSERT INTO paciente (Id,ApellidoPaterno,ApellidoMaterno,Nombre,TelContacto,Responsable,LugarResidencia,Estatus,Tipo) 
		values (@Id,@ApellidoPaterno,@ApellidoMaterno,@Nombre,@TelContacto,@Responsable,@LugarResidencia,@Estatus,@Tipo)
	END
	ELSE 
	BEGIN
		UPDATE paciente SET ApellidoPaterno=@ApellidoPaterno,ApellidoMaterno=@ApellidoMaterno,Nombre=@Nombre,
		TelContacto=@TelContacto,Responsable=@Responsable,LugarResidencia=@LugarResidencia,Estatus=@Estatus,Tipo=@Tipo
		WHERE Id=@Id
	END	
	SELECT 1 AS Guardado
	
	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerEstadosNotaEvolucion]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Obtener los estados de la nota de evolución.
-- =============================================
CREATE PROCEDURE [dbo].[ObtenerEstadosNotaEvolucion]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id, Nombre FROM estado 

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerListadoColaboradores]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 03/04/2022
-- Description:	listado de colaboradores 
-- =============================================
CREATE PROCEDURE [dbo].[ObtenerListadoColaboradores]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id, Nombre FROM colaboradores ORDER BY Nombre ASC 

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerListadoDeTiposTratamiento]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Obtener un listado de tipos de tratamiento.
-- =============================================
CREATE PROCEDURE [dbo].[ObtenerListadoDeTiposTratamiento]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id, Nombre FROM tipotratamiento ORDER BY Id ASC
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerListadoPacientes]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 20/03/2022
-- Description:	Obtener listado de pacientes para combo box.
-- =============================================
CREATE PROCEDURE [dbo].[ObtenerListadoPacientes]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id, ApellidoPaterno + ' ' + ApellidoMaterno + ' ' + Nombre AS NombreCompleto 
	From paciente 
	Order by ApellidoPaterno,ApellidoMaterno,Nombre ASC

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[ReporteColaboradores]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 21/03/2022
-- Description:	Reporte de colaboradores 
-- =============================================
CREATE PROCEDURE [dbo].[ReporteColaboradores]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT b.FechaEmision,a.Id,a.Nombre,b.Id as IdDetalle,b.Importe,
	CASE 
	WHEN b.Pagado=1 THEN 'SI' 
	WHEN b.Pagado=0 THEN 'NO' 
	ELSE 'SIN RESPUESTA'
	END AS EstaPagado,
	b.FechaPago,b.Concepto
	FROM colaboradores a 
	INNER JOIN colaboradoresDetalle b ON b.ColaboradorId=a.Id
	ORDER BY b.FechaEmision DESC

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[ReporteNotasEvolucion]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 21/03/2022
-- Description:	Reporte de notas de evolución
-- =============================================
CREATE PROCEDURE [dbo].[ReporteNotasEvolucion]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.Fecha,a.Id,a.Titulo,a.Descripcion,
	b.ApellidoPaterno + ' ' + b.ApellidoMaterno + ' ' + b.Nombre AS NombreCompleto,
	a.Usuario AS Colaborador,
	CASE 
	WHEN a.Estado=4 THEN 'SEVERA' 
	WHEN a.Estado=6 THEN 'MODERADA' 
	WHEN a.Estado=8 THEN 'LEVE' 
	WHEN a.Estado=10 THEN 'SATISFACTORIA' 
	ELSE 'SIN ESTADO'
	END AS EstadoNota
	FROM notaevolucion a
	INNER JOIN paciente b on b.Id=a.Paciente
	ORDER BY a.Fecha DESC

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[ReportePacientes]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 21/03/2022
-- Description:	Muestra todos los pacientes registrados
-- =============================================
CREATE PROCEDURE [dbo].[ReportePacientes]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id,ApellidoPaterno,ApellidoMaterno,Nombre,TelContacto,Responsable,LugarResidencia,
	CASE WHEN Estatus = '1' THEN 'ACTIVO' 
	WHEN Estatus = '2' THEN 'INACTIVO' 
	WHEN Estatus = '3' THEN 'BAJA' 	
	ELSE 
	'SIN STATUS'
	END AS Status,
	CASE WHEN Tipo = '1' THEN 'ETAPA_EXPERIMENTAL' 
	WHEN Tipo = '2' THEN 'SEGUIMIENTO_DE_TRATAMIENTO' 
	WHEN Tipo = '3' THEN 'PREVENCION_DE_RECAIDAS' 	
	ELSE 
	'SIN TRATAMIENTO'
	END AS Tratamiento
	FROM paciente 
	ORDER BY ApellidoPaterno,ApellidoMaterno,Nombre ASC

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UltimoIdColaboradorDetalle]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Traer el ultimo Id de colaborador detalle 
-- =============================================
CREATE PROCEDURE [dbo].[UltimoIdColaboradorDetalle]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 Id FROM colaboradoresDetalle ORDER BY Id desc

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UltimoIdColaboradorMaestro]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Traer el ultimo Id de colaborador maestro.
-- =============================================
CREATE PROCEDURE [dbo].[UltimoIdColaboradorMaestro]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 Id FROM colaboradores ORDER BY Id desc
END
GO
/****** Object:  StoredProcedure [dbo].[UltimoIdNotaEvolucion]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Traer el ultimo Id del catalogo de notas de evolución.
-- =============================================
CREATE PROCEDURE [dbo].[UltimoIdNotaEvolucion]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 Id FROM notaevolucion ORDER BY Id desc

	SET NOCOUNT OFF;
END
GO
/****** Object:  StoredProcedure [dbo].[UltimoIdPaciente]    Script Date: 18/05/2022 09:28:29 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		José Gilberto III Coronel Velázquez
-- Create date: 19/03/2022
-- Description:	Obtener el ultimo, Id del paciente. 
-- =============================================
CREATE PROCEDURE [dbo].[UltimoIdPaciente]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 Id FROM paciente ORDER BY Id desc 

	SET NOCOUNT OFF;
END
GO
