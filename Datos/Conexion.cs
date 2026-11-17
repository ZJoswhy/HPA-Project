using System.Text.Json;
using Microsoft.Data.SqlClient;

namespace GestionFlota.Datos;

/// <summary>
/// PERSONA 2 - Cadena de conexión.
/// Lee la cadena desde appsettings.json y entrega conexiones a SQL Server.
/// Si usan SQL Server Express, cambien "localhost" por ".\\SQLEXPRESS" en appsettings.json.
/// </summary>
public static class Conexion
{
    private static string? _cadena;

    public static string Cadena
    {
        get
        {
            if (_cadena is null)
            {
                string ruta = Path.Combine(AppContext.BaseDirectory, "appsettings.json");
                using JsonDocument doc = JsonDocument.Parse(File.ReadAllText(ruta));
                _cadena = doc.RootElement
                    .GetProperty("ConnectionStrings")
                    .GetProperty("GestionFlota")
                    .GetString()
                    ?? throw new InvalidOperationException("Falta la cadena de conexión en appsettings.json.");
            }
            return _cadena;
        }
    }

    /// <summary>Crea una conexión nueva (sin abrir). Usar siempre dentro de un "using".</summary>
    public static SqlConnection Crear() => new SqlConnection(Cadena);

    /// <summary>Intenta abrir la conexión y devuelve un mensaje con el resultado.</summary>
    public static bool ProbarConexion(out string mensaje)
    {
        try
        {
            using SqlConnection cn = Crear();
            cn.Open();
            mensaje = "Conexión exitosa a la base de datos " + cn.Database + ".";
            return true;
        }
        catch (Exception ex)
        {
            mensaje = "Error de conexión: " + ex.Message +
                      "\n\nRevise el nombre del servidor en appsettings.json y que el servicio de SQL Server esté iniciado.";
            return false;
        }
    }
}
