-- Crea la base GestionFlota con sus tablas y datos de prueba.
-- Si la base ya existe, la borra y la vuelve a crear con los datos originales.
USE [master]
GO
IF DB_ID('GestionFlota') IS NOT NULL
BEGIN
    ALTER DATABASE [GestionFlota] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [GestionFlota];
END
GO
-- Crear base de datos GestionFlota usando la ruta predeterminada de SQL Server.
USE [master]
GO
CREATE DATABASE [GestionFlota]
GO

USE [GestionFlota]
GO
/****** Object:  Table [dbo].[CONDUCTOR]    Script Date: 11/08/2026 6:57:52 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONDUCTOR](
	[Cedula] [varchar](20) NOT NULL,
	[Nombre] [varchar](40) NOT NULL,
	[Apellido] [varchar](40) NOT NULL,
	[Telefono] [varchar](20) NULL,
	[Licencia] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Conductor] PRIMARY KEY CLUSTERED 
(
	[Cedula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MANTENIMIENTO]    Script Date: 11/08/2026 6:57:52 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MANTENIMIENTO](
	[COD_Mantenimiento] [int] IDENTITY(1,1) NOT NULL,
	[Matricula] [varchar](15) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Tipo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](200) NOT NULL,
	[Costo] [decimal](10, 2) NOT NULL,
	[Km_servicio] [int] NOT NULL,
 CONSTRAINT [PK_Mantenimiento] PRIMARY KEY CLUSTERED 
(
	[COD_Mantenimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VEHICULO]    Script Date: 11/08/2026 6:57:52 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VEHICULO](
	[Matricula] [varchar](15) NOT NULL,
	[Marca] [varchar](30) NOT NULL,
	[Modelo] [varchar](30) NOT NULL,
	[Anio] [int] NOT NULL,
	[Color] [varchar](20) NULL,
	[Tipo_comb] [varchar](20) NOT NULL,
	[Km_actual] [int] NOT NULL,
	[Estado] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Vehiculo] PRIMARY KEY CLUSTERED 
(
	[Matricula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VIAJE]    Script Date: 11/08/2026 6:57:52 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VIAJE](
	[COD_Viaje] [int] IDENTITY(1,1) NOT NULL,
	[Matricula] [varchar](15) NOT NULL,
	[Cedula] [varchar](20) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Origen] [varchar](60) NOT NULL,
	[Destino] [varchar](60) NOT NULL,
	[Km_inicial] [int] NOT NULL,
	[Km_final] [int] NOT NULL,
	[Litros_consumidos] [decimal](6, 2) NOT NULL,
 CONSTRAINT [PK_Viaje] PRIMARY KEY CLUSTERED 
(
	[COD_Viaje] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[CONDUCTOR] ([Cedula], [Nombre], [Apellido], [Telefono], [Licencia]) VALUES (N'8-000-0001', N'Carlos', N'Rodriguez', N'6000-0001', N'LIC-0001')
INSERT [dbo].[CONDUCTOR] ([Cedula], [Nombre], [Apellido], [Telefono], [Licencia]) VALUES (N'8-000-0002', N'Alessandra', N'Moreno', N'6000-0002', N'LIC-0002')
INSERT [dbo].[CONDUCTOR] ([Cedula], [Nombre], [Apellido], [Telefono], [Licencia]) VALUES (N'8-000-0003', N'Jose', N'Rodriguez', N'6000-0003', N'LIC-0003')
INSERT [dbo].[CONDUCTOR] ([Cedula], [Nombre], [Apellido], [Telefono], [Licencia]) VALUES (N'8-000-0004', N'Daniela', N'Castillo', N'6000-0004', N'LIC-0004')
INSERT [dbo].[CONDUCTOR] ([Cedula], [Nombre], [Apellido], [Telefono], [Licencia]) VALUES (N'8-000-0005', N'Isaias', N'Reyes', N'6000-0005', N'LIC-0005')
INSERT [dbo].[CONDUCTOR] ([Cedula], [Nombre], [Apellido], [Telefono], [Licencia]) VALUES (N'8-000-0006', N'Andrea', N'Morales', N'6000-0006', N'LIC-0006')
GO
SET IDENTITY_INSERT [dbo].[MANTENIMIENTO] ON 

INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (1, N'ABC-101', CAST(N'2026-02-10' AS Date), N'Preventivo', N'Cambio de aceite y filtros', CAST(85.00 AS Decimal(10, 2)), 76250)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (2, N'ABC-101', CAST(N'2026-09-01' AS Date), N'Preventivo', N'Revision de frenos y rotacion de llantas', CAST(145.00 AS Decimal(10, 2)), 77000)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (3, N'ABC-102', CAST(N'2026-02-15' AS Date), N'Preventivo', N'Cambio de aceite y filtro de aire', CAST(78.50 AS Decimal(10, 2)), 63250)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (4, N'ABC-102', CAST(N'2026-07-20' AS Date), N'Correctivo', N'Reemplazo de pastillas de freno', CAST(190.00 AS Decimal(10, 2)), 63700)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (5, N'ABC-103', CAST(N'2026-03-15' AS Date), N'Correctivo', N'Reparacion del sistema de suspension', CAST(420.00 AS Decimal(10, 2)), 102300)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (6, N'ABC-103', CAST(N'2026-08-05' AS Date), N'Preventivo', N'Inspeccion general y cambio de filtros', CAST(160.00 AS Decimal(10, 2)), 102900)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (7, N'ABC-104', CAST(N'2026-03-10' AS Date), N'Preventivo', N'Cambio de aceite y revision general', CAST(72.00 AS Decimal(10, 2)), 87200)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (8, N'ABC-104', CAST(N'2026-06-25' AS Date), N'Correctivo', N'Cambio de bateria', CAST(115.00 AS Decimal(10, 2)), 87600)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (9, N'ABC-105', CAST(N'2026-05-05' AS Date), N'Preventivo', N'Cambio de aceite y filtros', CAST(110.00 AS Decimal(10, 2)), 44200)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (10, N'ABC-105', CAST(N'2026-07-30' AS Date), N'Correctivo', N'Reparacion del sistema de refrigeracion', CAST(265.00 AS Decimal(10, 2)), 44600)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (11, N'ABC-106', CAST(N'2026-03-20' AS Date), N'Preventivo', N'Revision del sistema hibrido y cambio de aceite', CAST(130.00 AS Decimal(10, 2)), 37500)
INSERT [dbo].[MANTENIMIENTO] ([COD_Mantenimiento], [Matricula], [Fecha], [Tipo], [Descripcion], [Costo], [Km_servicio]) VALUES (12, N'ABC-106', CAST(N'2026-07-15' AS Date), N'Preventivo', N'Revision de frenos y diagnostico electronico', CAST(95.00 AS Decimal(10, 2)), 37900)
SET IDENTITY_INSERT [dbo].[MANTENIMIENTO] OFF
GO
INSERT [dbo].[VEHICULO] ([Matricula], [Marca], [Modelo], [Anio], [Color], [Tipo_comb], [Km_actual], [Estado]) VALUES (N'ABC-101', N'Toyota', N'Hilux', 2022, N'Blanco', N'Diesel', 78500, N'Activo')
INSERT [dbo].[VEHICULO] ([Matricula], [Marca], [Modelo], [Anio], [Color], [Tipo_comb], [Km_actual], [Estado]) VALUES (N'ABC-102', N'Hyundai', N'Tucson', 2021, N'Gris', N'Gasolina', 64200, N'Activo')
INSERT [dbo].[VEHICULO] ([Matricula], [Marca], [Modelo], [Anio], [Color], [Tipo_comb], [Km_actual], [Estado]) VALUES (N'ABC-103', N'Nissan', N'Frontier', 2020, N'Rojo', N'Diesel', 103500, N'En taller')
INSERT [dbo].[VEHICULO] ([Matricula], [Marca], [Modelo], [Anio], [Color], [Tipo_comb], [Km_actual], [Estado]) VALUES (N'ABC-104', N'Kia', N'Rio', 2019, N'Azul', N'Gasolina', 88700, N'Activo')
INSERT [dbo].[VEHICULO] ([Matricula], [Marca], [Modelo], [Anio], [Color], [Tipo_comb], [Km_actual], [Estado]) VALUES (N'ABC-105', N'Mitsubishi', N'L200', 2023, N'Plateado', N'Diesel', 45200, N'Activo')
INSERT [dbo].[VEHICULO] ([Matricula], [Marca], [Modelo], [Anio], [Color], [Tipo_comb], [Km_actual], [Estado]) VALUES (N'ABC-106', N'Toyota', N'Corolla', 2022, N'Negro', N'Hibrido', 39800, N'Activo')
GO
SET IDENTITY_INSERT [dbo].[VIAJE] ON 

INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (1, N'ABC-101', N'8-000-0001', CAST(N'2026-01-15' AS Date), N'Ciudad de Panama', N'Colon', 76100, 76240, CAST(18.50 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (2, N'ABC-101', N'8-000-0002', CAST(N'2026-03-12' AS Date), N'Colon', N'Ciudad de Panama', 76250, 76520, CAST(32.00 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (3, N'ABC-101', N'8-000-0001', CAST(N'2026-08-20' AS Date), N'Ciudad de Panama', N'Santiago', 76520, 76980, CAST(55.00 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (4, N'ABC-102', N'8-000-0003', CAST(N'2026-01-22' AS Date), N'San Miguelito', N'Chorrera', 63100, 63240, CAST(12.40 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (5, N'ABC-102', N'8-000-0004', CAST(N'2026-04-18' AS Date), N'Chorrera', N'Ciudad de Panama', 63250, 63560, CAST(27.80 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (6, N'ABC-102', N'8-000-0003', CAST(N'2026-09-10' AS Date), N'Ciudad de Panama', N'Penonome', 63800, 64120, CAST(31.60 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (7, N'ABC-103', N'8-000-0005', CAST(N'2026-02-05' AS Date), N'Ciudad de Panama', N'David', 102000, 102180, CAST(24.00 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (8, N'ABC-103', N'8-000-0006', CAST(N'2026-05-12' AS Date), N'David', N'Santiago', 102300, 102450, CAST(19.50 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (9, N'ABC-104', N'8-000-0002', CAST(N'2026-01-30' AS Date), N'Ciudad de Panama', N'Arraijan', 87000, 87150, CAST(9.20 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (10, N'ABC-104', N'8-000-0004', CAST(N'2026-05-20' AS Date), N'Arraijan', N'Ciudad de Panama', 87200, 87500, CAST(18.70 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (11, N'ABC-104', N'8-000-0002', CAST(N'2026-10-02' AS Date), N'Ciudad de Panama', N'Las Tablas', 87800, 88200, CAST(24.30 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (12, N'ABC-105', N'8-000-0005', CAST(N'2026-04-08' AS Date), N'Ciudad de Panama', N'Penonome', 43800, 44120, CAST(38.00 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (13, N'ABC-105', N'8-000-0001', CAST(N'2026-06-15' AS Date), N'Penonome', N'Santiago', 44200, 44500, CAST(35.50 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (14, N'ABC-105', N'8-000-0005', CAST(N'2026-09-25' AS Date), N'Santiago', N'Ciudad de Panama', 44700, 45000, CAST(36.20 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (15, N'ABC-106', N'8-000-0006', CAST(N'2026-02-18' AS Date), N'San Miguelito', N'Ciudad de Panama', 37200, 37450, CAST(8.10 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (16, N'ABC-106', N'8-000-0003', CAST(N'2026-05-26' AS Date), N'Ciudad de Panama', N'Tocumen', 37500, 37800, CAST(9.40 AS Decimal(6, 2)))
INSERT [dbo].[VIAJE] ([COD_Viaje], [Matricula], [Cedula], [Fecha], [Origen], [Destino], [Km_inicial], [Km_final], [Litros_consumidos]) VALUES (17, N'ABC-106', N'8-000-0006', CAST(N'2026-10-15' AS Date), N'Tocumen', N'Ciudad de Panama', 38000, 38500, CAST(14.20 AS Decimal(6, 2)))
SET IDENTITY_INSERT [dbo].[VIAJE] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Conductor_Licencia]    Script Date: 11/08/2026 6:57:52 p. m. ******/
ALTER TABLE [dbo].[CONDUCTOR] ADD  CONSTRAINT [UQ_Conductor_Licencia] UNIQUE NONCLUSTERED 
(
	[Licencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MANTENIMIENTO] ADD  CONSTRAINT [DF_Mant_Fecha]  DEFAULT (CONVERT([date],getdate())) FOR [Fecha]
GO
ALTER TABLE [dbo].[VEHICULO] ADD  CONSTRAINT [DF_Vehiculo_Km]  DEFAULT ((0)) FOR [Km_actual]
GO
ALTER TABLE [dbo].[VEHICULO] ADD  CONSTRAINT [DF_Vehiculo_Estado]  DEFAULT ('Activo') FOR [Estado]
GO
ALTER TABLE [dbo].[VIAJE] ADD  CONSTRAINT [DF_Viaje_Fecha]  DEFAULT (CONVERT([date],getdate())) FOR [Fecha]
GO
ALTER TABLE [dbo].[MANTENIMIENTO]  WITH CHECK ADD  CONSTRAINT [FK_Mant_Vehiculo] FOREIGN KEY([Matricula])
REFERENCES [dbo].[VEHICULO] ([Matricula])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[MANTENIMIENTO] CHECK CONSTRAINT [FK_Mant_Vehiculo]
GO
ALTER TABLE [dbo].[VIAJE]  WITH CHECK ADD  CONSTRAINT [FK_Viaje_Conductor] FOREIGN KEY([Cedula])
REFERENCES [dbo].[CONDUCTOR] ([Cedula])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[VIAJE] CHECK CONSTRAINT [FK_Viaje_Conductor]
GO
ALTER TABLE [dbo].[VIAJE]  WITH CHECK ADD  CONSTRAINT [FK_Viaje_Vehiculo] FOREIGN KEY([Matricula])
REFERENCES [dbo].[VEHICULO] ([Matricula])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[VIAJE] CHECK CONSTRAINT [FK_Viaje_Vehiculo]
GO
ALTER TABLE [dbo].[MANTENIMIENTO]  WITH CHECK ADD  CONSTRAINT [CK_Mant_Costo] CHECK  (([Costo]>=(0)))
GO
ALTER TABLE [dbo].[MANTENIMIENTO] CHECK CONSTRAINT [CK_Mant_Costo]
GO
ALTER TABLE [dbo].[MANTENIMIENTO]  WITH CHECK ADD  CONSTRAINT [CK_Mant_KmServicio] CHECK  (([Km_servicio]>=(0)))
GO
ALTER TABLE [dbo].[MANTENIMIENTO] CHECK CONSTRAINT [CK_Mant_KmServicio]
GO
ALTER TABLE [dbo].[MANTENIMIENTO]  WITH CHECK ADD  CONSTRAINT [CK_Mant_Tipo] CHECK  (([Tipo]='Correctivo' OR [Tipo]='Preventivo'))
GO
ALTER TABLE [dbo].[MANTENIMIENTO] CHECK CONSTRAINT [CK_Mant_Tipo]
GO
ALTER TABLE [dbo].[VEHICULO]  WITH CHECK ADD  CONSTRAINT [CK_Vehiculo_Anio] CHECK  (([Anio]>=(1950) AND [Anio]<=(2100)))
GO
ALTER TABLE [dbo].[VEHICULO] CHECK CONSTRAINT [CK_Vehiculo_Anio]
GO
ALTER TABLE [dbo].[VEHICULO]  WITH CHECK ADD  CONSTRAINT [CK_Vehiculo_Estado] CHECK  (([Estado]='De baja' OR [Estado]='En taller' OR [Estado]='Activo'))
GO
ALTER TABLE [dbo].[VEHICULO] CHECK CONSTRAINT [CK_Vehiculo_Estado]
GO
ALTER TABLE [dbo].[VEHICULO]  WITH CHECK ADD  CONSTRAINT [CK_Vehiculo_Km] CHECK  (([Km_actual]>=(0)))
GO
ALTER TABLE [dbo].[VEHICULO] CHECK CONSTRAINT [CK_Vehiculo_Km]
GO
ALTER TABLE [dbo].[VEHICULO]  WITH CHECK ADD  CONSTRAINT [CK_Vehiculo_TipoComb] CHECK  (([Tipo_comb]='Electrico' OR [Tipo_comb]='Hibrido' OR [Tipo_comb]='Gas' OR [Tipo_comb]='Diesel' OR [Tipo_comb]='Gasolina'))
GO
ALTER TABLE [dbo].[VEHICULO] CHECK CONSTRAINT [CK_Vehiculo_TipoComb]
GO
ALTER TABLE [dbo].[VIAJE]  WITH CHECK ADD  CONSTRAINT [CK_Viaje_KmFinal] CHECK  (([Km_final]>=[Km_inicial]))
GO
ALTER TABLE [dbo].[VIAJE] CHECK CONSTRAINT [CK_Viaje_KmFinal]
GO
ALTER TABLE [dbo].[VIAJE]  WITH CHECK ADD  CONSTRAINT [CK_Viaje_KmInicial] CHECK  (([Km_inicial]>=(0)))
GO
ALTER TABLE [dbo].[VIAJE] CHECK CONSTRAINT [CK_Viaje_KmInicial]
GO
ALTER TABLE [dbo].[VIAJE]  WITH CHECK ADD  CONSTRAINT [CK_Viaje_Litros] CHECK  (([Litros_consumidos]>=(0)))
GO
ALTER TABLE [dbo].[VIAJE] CHECK CONSTRAINT [CK_Viaje_Litros]
GO
USE [master]
GO
ALTER DATABASE [GestionFlota] SET  READ_WRITE 
GO
