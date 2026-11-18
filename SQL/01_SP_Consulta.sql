-- PERSONA 3 - Procedimientos almacenados de CONSULTA
-- Ejecutar DESPUÉS de crear la base GestionFlota (script del Grupo 1).
USE GestionFlota;
GO

CREATE OR ALTER PROCEDURE dbo.sp_ListarVehiculos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Matricula, Marca, Modelo, Anio, Color, Tipo_comb, Km_actual, Estado
    FROM dbo.VEHICULO
    ORDER BY Matricula;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ListarConductores
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Cedula, Nombre, Apellido, Nombre + ' ' + Apellido AS NombreCompleto, Telefono, Licencia
    FROM dbo.CONDUCTOR
    ORDER BY Apellido, Nombre;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_BuscarVehiculoPorMatricula
    @Matricula VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT Matricula, Marca, Modelo, Anio, Color, Tipo_comb, Km_actual, Estado
    FROM dbo.VEHICULO
    WHERE Matricula = @Matricula;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_ViajesPorVehiculo
    @Matricula VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT v.COD_Viaje, v.Fecha, c.Nombre + ' ' + c.Apellido AS Conductor,
           v.Origen, v.Destino, v.Km_inicial, v.Km_final,
           v.Km_final - v.Km_inicial AS Km_recorridos,
           v.Litros_consumidos
    FROM dbo.VIAJE v
    INNER JOIN dbo.CONDUCTOR c ON c.Cedula = v.Cedula
    WHERE v.Matricula = @Matricula
    ORDER BY v.Fecha DESC, v.COD_Viaje DESC;
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_MantenimientosPorVehiculo
    @Matricula VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT COD_Mantenimiento, Fecha, Tipo, Descripcion, Costo, Km_servicio
    FROM dbo.MANTENIMIENTO
    WHERE Matricula = @Matricula
    ORDER BY Fecha DESC, COD_Mantenimiento DESC;
END
GO


-- Consultar los vehículos que se encuentran en el taller.
CREATE OR ALTER PROCEDURE dbo.sp_VehiculosEnTaller
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Matricula, Marca, Modelo, Anio, Color,
           Tipo_comb, Km_actual, Estado
    FROM dbo.VEHICULO
    WHERE Estado = 'En taller'
    ORDER BY Matricula;
END
GO

-- Consultar el consumo y rendimiento de combustible de un vehículo.
CREATE OR ALTER PROCEDURE dbo.sp_ConsumoPorVehiculo
    @Matricula VARCHAR(15)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        v.Matricula,
        v.Marca,
        v.Modelo,
        COUNT(vi.COD_Viaje) AS Total_viajes,
        COALESCE(SUM(vi.Km_final - vi.Km_inicial), 0) AS Km_recorridos,
        COALESCE(SUM(vi.Litros_consumidos), 0) AS Litros_consumidos,
        CAST(
            SUM(vi.Km_final - vi.Km_inicial) * 1.0 /
            NULLIF(SUM(vi.Litros_consumidos), 0)
            AS DECIMAL(10,2)
        ) AS Rendimiento_KmPorLitro
    FROM dbo.VEHICULO v
    LEFT JOIN dbo.VIAJE vi ON v.Matricula = vi.Matricula
    WHERE v.Matricula = @Matricula
    GROUP BY v.Matricula, v.Marca, v.Modelo;
END
GO


-- Consultar el historial de viajes de un conductor.
CREATE OR ALTER PROCEDURE dbo.sp_HistorialViajesConductor
    @Cedula VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.Cedula,
        c.Nombre + ' ' + c.Apellido AS Conductor,
        v.COD_Viaje,
        v.Matricula,
        v.Fecha,
        v.Origen,
        v.Destino,
        v.Km_inicial,
        v.Km_final,
        v.Km_final - v.Km_inicial AS Km_recorridos
    FROM dbo.VIAJE v
    INNER JOIN dbo.CONDUCTOR c ON v.Cedula = c.Cedula
    WHERE c.Cedula = @Cedula
    ORDER BY v.Fecha DESC, v.COD_Viaje DESC;
END
GO


-- Pruebas rápidas (seleccionar y ejecutar con F5):
-- EXEC dbo.sp_ListarVehiculos;
-- EXEC dbo.sp_ListarConductores;
-- EXEC dbo.sp_BuscarVehiculoPorMatricula @Matricula = 'ABC-101';
-- EXEC dbo.sp_ViajesPorVehiculo @Matricula = 'ABC-101';
-- EXEC dbo.sp_MantenimientosPorVehiculo @Matricula = 'ABC-101';
-- EXEC dbo.sp_VehiculosEnTaller;
-- EXEC dbo.sp_ConsumoPorVehiculo @Matricula = 'ABC-101';
-- EXEC dbo.sp_HistorialViajesConductor @Cedula = '8-000-0001';
