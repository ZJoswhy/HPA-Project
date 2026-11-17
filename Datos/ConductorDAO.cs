using System.Data;
using Microsoft.Data.SqlClient;
using GestionFlota.Modelos;

namespace GestionFlota.Datos;

/// PERSONA 5 - Acceso a datos de CONDUCTOR.
public static class ConductorDAO
{
    public static DataTable Listar() =>
        DataHelper.Consultar("dbo.sp_ListarConductores");

    public static void Insertar(Conductor c) =>
        DataHelper.Ejecutar("dbo.sp_InsertarConductor",
            new SqlParameter("@Cedula", c.Cedula),
            new SqlParameter("@Nombre", c.Nombre),
            new SqlParameter("@Apellido", c.Apellido),
            new SqlParameter("@Telefono", DataHelper.Valor(c.Telefono)),
            new SqlParameter("@Licencia", c.Licencia));
}
