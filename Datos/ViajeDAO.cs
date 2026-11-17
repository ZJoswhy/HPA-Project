using System.Data;
using Microsoft.Data.SqlClient;
using GestionFlota.Modelos;

namespace GestionFlota.Datos;

/// PERSONA 5 - Acceso a datos de VIAJE.
public static class ViajeDAO
{
    public static DataTable PorVehiculo(string matricula) =>
        DataHelper.Consultar("dbo.sp_ViajesPorVehiculo",
            new SqlParameter("@Matricula", matricula));

    /// <summary>Registra el viaje y devuelve el código generado.</summary>
    public static int Registrar(Viaje v)
    {
        SqlParameter salida = DataHelper.ParametroSalida("@COD_Viaje");

        DataHelper.Ejecutar("dbo.sp_RegistrarViaje",
            new SqlParameter("@Matricula", v.Matricula),
            new SqlParameter("@Cedula", v.Cedula),
            new SqlParameter("@Fecha", v.Fecha.Date),
            new SqlParameter("@Origen", v.Origen),
            new SqlParameter("@Destino", v.Destino),
            new SqlParameter("@Km_inicial", v.Km_inicial),
            new SqlParameter("@Km_final", v.Km_final),
            new SqlParameter("@Litros", v.Litros_consumidos),
            salida);

        return (int)salida.Value;
    }
}
