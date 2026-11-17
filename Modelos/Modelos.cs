namespace GestionFlota.Modelos;

/// PERSONA 5 - Clases modelo (representan las filas de cada tabla).

public class Vehiculo
{
    public string Matricula { get; set; } = "";
    public string Marca { get; set; } = "";
    public string Modelo { get; set; } = "";
    public int Anio { get; set; }
    public string? Color { get; set; }
    public string Tipo_comb { get; set; } = "Gasolina";
    public int Km_actual { get; set; }
    public string Estado { get; set; } = "Activo";
}

public class Conductor
{
    public string Cedula { get; set; } = "";
    public string Nombre { get; set; } = "";
    public string Apellido { get; set; } = "";
    public string? Telefono { get; set; }
    public string Licencia { get; set; } = "";
}

public class Viaje
{
    public int COD_Viaje { get; set; }
    public string Matricula { get; set; } = "";
    public string Cedula { get; set; } = "";
    public DateTime Fecha { get; set; } = DateTime.Today;
    public string Origen { get; set; } = "";
    public string Destino { get; set; } = "";
    public int Km_inicial { get; set; }
    public int Km_final { get; set; }
    public decimal Litros_consumidos { get; set; }
}

public class Mantenimiento
{
    public int COD_Mantenimiento { get; set; }
    public string Matricula { get; set; } = "";
    public DateTime Fecha { get; set; } = DateTime.Today;
    public string Tipo { get; set; } = "Preventivo";
    public string Descripcion { get; set; } = "";
    public decimal Costo { get; set; }
    public int Km_servicio { get; set; }
}
