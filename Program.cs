using GestionFlota.Datos;
using GestionFlota.Presentacion;

namespace GestionFlota;

internal static class Program
{
    [STAThread]
    static int Main(string[] args)
    {
        if (args.Length == 1 && args[0] == "--probar-conexion")
            return Conexion.ProbarConexion() ? 0 : 1;

        ApplicationConfiguration.Initialize();

        // Persona 2: prueba de la cadena de conexión antes de abrir la app
        if (!Conexion.ProbarConexion(out string mensaje))
        {
            MessageBox.Show(mensaje, "No se pudo conectar", MessageBoxButtons.OK, MessageBoxIcon.Error);
            return 1;
        }

        Application.Run(new FormPrincipal());
        return 0;
    }
}
