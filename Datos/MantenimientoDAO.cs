using System.Data;
using Microsoft.Data.SqlClient;
using GestionFlota.Modelos;

namespace GestionFlota.Datos;

/// PERSONA 5 - Acceso a datos de MANTENIMIENTO.
public static class MantenimientoDAO
{
    public static DataTable PorVehiculo(string matricula) =>
        DataHelper.Consultar("dbo.sp_MantenimientosPorVehiculo",
            new SqlParameter("@Matricula", matricula));

    /// <summary>Registra el mantenimiento y devuelve el código generado.</summary>
    public static int Registrar(Mantenimiento m)
    {
        SqlParameter salida = DataHelper.ParametroSalida("@COD_Mantenimiento");

        DataHelper.Ejecutar("dbo.sp_RegistrarMantenimiento",
            new SqlParameter("@Matricula", m.Matricula),
            new SqlParameter("@Fecha", m.Fecha.Date),
            new SqlParameter("@Tipo", m.Tipo),
            new SqlParameter("@Descripcion", m.Descripcion),
            new SqlParameter("@Costo", m.Costo),
            new SqlParameter("@Km_servicio", m.Km_servicio),
            salida);

        return (int)salida.Value;
    }
}
