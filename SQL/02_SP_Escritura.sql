-- PERSONA 4 - Procedimientos almacenados de ESCRITURA
-- Parámetros de entrada/salida, TRY...CATCH y transacciones.
USE GestionFlota;
GO

CREATE OR ALTER PROCEDURE dbo.sp_InsertarVehiculo
    @Matricula  VARCHAR(15),
    @Marca      VARCHAR(30),
    @Modelo     VARCHAR(30),
    @Anio       INT,
    @Color      VARCHAR(20) = NULL,
    @Tipo_comb  VARCHAR(20),
    @Km_actual  INT = 0,
    @Estado     VARCHAR(20) = 'Activo'
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM dbo.VEHICULO WHERE Matricula = @Matricula)
            THROW 50001, 'Ya existe un vehiculo con esa matricula.', 1;

        INSERT INTO dbo.VEHICULO (Matricula, Marca, Modelo, Anio, Color, Tipo_comb, Km_actual, Estado)
        VALUES (@Matricula, @Marca, @Modelo, @Anio, @Color, @Tipo_comb, @Km_actual, @Estado);
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_InsertarConductor
    @Cedula    VARCHAR(20),
    @Nombre    VARCHAR(40),
    @Apellido  VARCHAR(40),
    @Telefono  VARCHAR(20) = NULL,
    @Licencia  VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM dbo.CONDUCTOR WHERE Cedula = @Cedula)
            THROW 50005, 'Ya existe un conductor con esa cedula.', 1;
        IF EXISTS (SELECT 1 FROM dbo.CONDUCTOR WHERE Licencia = @Licencia)
            THROW 50006, 'Ya existe un conductor con ese numero de licencia.', 1;

        INSERT INTO dbo.CONDUCTOR (Cedula, Nombre, Apellido, Telefono, Licencia)
        VALUES (@Cedula, @Nombre, @Apellido, @Telefono, @Licencia);
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

-- Registra el viaje Y actualiza Km_actual del vehículo (la BD no lo hace sola).
CREATE OR ALTER PROCEDURE dbo.sp_RegistrarViaje
    @Matricula  VARCHAR(15),
    @Cedula     VARCHAR(20),
    @Fecha      DATE,
    @Origen     VARCHAR(60),
    @Destino    VARCHAR(60),
    @Km_inicial INT,
    @Km_final   INT,
    @Litros     DECIMAL(6,2),
    @COD_Viaje  INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM dbo.VEHICULO WHERE Matricula = @Matricula)
            THROW 50002, 'El vehiculo no existe.', 1;
        IF NOT EXISTS (SELECT 1 FROM dbo.CONDUCTOR WHERE Cedula = @Cedula)
            THROW 50003, 'El conductor no existe.', 1;
        IF @Km_final < @Km_inicial
            THROW 50004, 'El kilometraje final no puede ser menor que el inicial.', 1;

        BEGIN TRANSACTION;

        INSERT INTO dbo.VIAJE (Matricula, Cedula, Fecha, Origen, Destino, Km_inicial, Km_final, Litros_consumidos)
        VALUES (@Matricula, @Cedula, @Fecha, @Origen, @Destino, @Km_inicial, @Km_final, @Litros);

        SET @COD_Viaje = SCOPE_IDENTITY();

        UPDATE dbo.VEHICULO
        SET Km_actual = @Km_final
        WHERE Matricula = @Matricula AND Km_actual < @Km_final;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_RegistrarMantenimiento
    @Matricula       VARCHAR(15),
    @Fecha           DATE = NULL,
    @Tipo            VARCHAR(20),
    @Descripcion     VARCHAR(200),
    @Costo           DECIMAL(10,2),
    @Km_servicio     INT,
    @COD_Mantenimiento INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM dbo.VEHICULO WHERE Matricula = @Matricula)
            THROW 50002, 'El vehiculo no existe.', 1;
        IF @Tipo NOT IN ('Preventivo', 'Correctivo')
            THROW 50007, 'El tipo debe ser Preventivo o Correctivo.', 1;

        INSERT INTO dbo.MANTENIMIENTO (Matricula, Fecha, Tipo, Descripcion, Costo, Km_servicio)
        VALUES (@Matricula, ISNULL(@Fecha, CAST(GETDATE() AS DATE)), @Tipo, @Descripcion, @Costo, @Km_servicio);

        SET @COD_Mantenimiento = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ActualizarEstadoVehiculo
    @Matricula VARCHAR(15),
    @Estado    VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @Estado NOT IN ('Activo', 'En taller', 'De baja')
            THROW 50008, 'Estado no valido (Activo, En taller o De baja).', 1;

        UPDATE dbo.VEHICULO SET Estado = @Estado WHERE Matricula = @Matricula;

        IF @@ROWCOUNT = 0
            THROW 50009, 'No se encontro el vehiculo.', 1;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

-- Pruebas (las que dicen "debe fallar" deben dar error):
-- DECLARE @id INT;
-- EXEC dbo.sp_RegistrarViaje 'ABC-101','8-000-0001','2026-11-01','Panama','Colon',78500,78600,10.5,@id OUTPUT;
-- SELECT @id AS NuevoViaje; SELECT Matricula, Km_actual FROM dbo.VEHICULO WHERE Matricula='ABC-101';
-- EXEC dbo.sp_RegistrarViaje 'ABC-101','8-000-0001','2026-11-01','Panama','David',5000,4000,20,@id OUTPUT;   -- debe fallar
-- EXEC dbo.sp_RegistrarViaje 'ZZ-0000','8-000-0001','2026-11-01','Panama','David',100,200,20,@id OUTPUT;     -- debe fallar
-- EXEC dbo.sp_ActualizarEstadoVehiculo 'ABC-103','Activo';
-- SELECT Matricula, Estado FROM dbo.VEHICULO WHERE Matricula = 'ABC-103';
-- EXEC dbo.sp_ActualizarEstadoVehiculo 'ABC-101', 'Disponible'; -- debe fallar
-- DECLARE @idMantenimiento INT;
-- EXEC dbo.sp_RegistrarMantenimiento 'ABC-101', '2026-11-05', 'Limpieza', 'Lavado general', 25.00, 78700, @idMantenimiento OUTPUT; -- debe fallar
-- EXEC dbo.sp_RegistrarViaje 'ABC-101', '8-00-0001', '2026-11-04', '', 'Colon', 78600, 78700, 15, @id OUTPUT; -- debe fallar
-- EXEC dbo.sp_RegistrarMantenimiento 'ABC-101','2026-11-06', 'Correctivo', 'Cambio de frenos delanteros', 350.00, 78700, @idMantenimiento OUTPUT;
-- SELECT * FROM dbo.MANTENIMIENTO WHERE COD_Mantenimiento = @idMantenimiento;
