using System.Data;
using Microsoft.Data.SqlClient;
using GestionFlota.Modelos;

namespace GestionFlota.Datos;

/// PERSONA 5 - Acceso a datos de VEHICULO (usa los SP de las Personas 3 y 4).
public static class VehiculoDAO
{
    public static DataTable Listar() =>
        DataHelper.Consultar("dbo.sp_ListarVehiculos");

    public static DataTable Buscar(string matricula) =>
        DataHelper.Consultar("dbo.sp_BuscarVehiculoPorMatricula",
            new SqlParameter("@Matricula", matricula));

    public static void Insertar(Vehiculo v) =>
        DataHelper.Ejecutar("dbo.sp_InsertarVehiculo",
            new SqlParameter("@Matricula", v.Matricula),
            new SqlParameter("@Marca", v.Marca),
            new SqlParameter("@Modelo", v.Modelo),
            new SqlParameter("@Anio", v.Anio),
            new SqlParameter("@Color", DataHelper.Valor(v.Color)),
            new SqlParameter("@Tipo_comb", v.Tipo_comb),
            new SqlParameter("@Km_actual", v.Km_actual),
            new SqlParameter("@Estado", v.Estado));

    public static void CambiarEstado(string matricula, string estado) =>
        DataHelper.Ejecutar("dbo.sp_ActualizarEstadoVehiculo",
            new SqlParameter("@Matricula", matricula),
            new SqlParameter("@Estado", estado));
}
