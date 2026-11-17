using GestionFlota.Datos;
using GestionFlota.Presentacion;

namespace GestionFlota;

internal static class Program
{
    [STAThread]
    static void Main()
    {
        ApplicationConfiguration.Initialize();

        // Persona 2: prueba de la cadena de conexión antes de abrir la app
        if (!Conexion.ProbarConexion(out string mensaje))
        {
            MessageBox.Show(mensaje, "No se pudo conectar", MessageBoxButtons.OK, MessageBoxIcon.Error);
            return;
        }

        Application.Run(new FormPrincipal());
    }
}
