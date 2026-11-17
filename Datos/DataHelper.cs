using System.Data;
using Microsoft.Data.SqlClient;

namespace GestionFlota.Datos;

/// <summary>
/// PERSONA 5 - Ayudante que ejecuta procedimientos almacenados.
/// Abre la conexión de la Persona 2, llama al SP y cierra todo.
/// </summary>
public static class DataHelper
{
    /// <summary>Ejecuta un SP que devuelve filas (SELECT).</summary>
    public static DataTable Consultar(string procedimiento, params SqlParameter[] parametros)
    {
        using SqlConnection cn = Conexion.Crear();
        using SqlCommand cmd = new(procedimiento, cn) { CommandType = CommandType.StoredProcedure };
        cmd.Parameters.AddRange(parametros);

        using SqlDataAdapter da = new(cmd);
        DataTable tabla = new();
        da.Fill(tabla);
        return tabla;
    }

    /// <summary>Ejecuta un SP que escribe datos (INSERT/UPDATE/DELETE).</summary>
    public static void Ejecutar(string procedimiento, params SqlParameter[] parametros)
    {
        using SqlConnection cn = Conexion.Crear();
        using SqlCommand cmd = new(procedimiento, cn) { CommandType = CommandType.StoredProcedure };
        cmd.Parameters.AddRange(parametros);

        cn.Open();
        cmd.ExecuteNonQuery();
    }

    /// <summary>Crea un parámetro de salida entero (para recibir el código generado).</summary>
    public static SqlParameter ParametroSalida(string nombre) =>
        new(nombre, SqlDbType.Int) { Direction = ParameterDirection.Output };

    /// <summary>Convierte null en DBNull para enviarlo a SQL Server.</summary>
    public static object Valor(object? v) => v ?? DBNull.Value;
}
