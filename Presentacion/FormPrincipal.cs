using System.Data;
using Microsoft.Data.SqlClient;
using GestionFlota.Datos;
using GestionFlota.Modelos;

namespace GestionFlota.Presentacion;

/// <summary>
/// PERSONA 6 - Cliente (Windows Forms).
/// Pestañas: Vehículos (listado), Viajes (consultar y registrar), Mantenimientos (consultar y registrar).
/// El formulario NO toca SQL: solo llama a los DAO de la Persona 5.
/// </summary>
public class FormPrincipal : Form
{
    private readonly TabControl _tabs = new() { Dock = DockStyle.Fill };

    // --- Vehículos ---
    private readonly DataGridView _gridVehiculos = NuevaGrid();

    // --- Viajes ---
    private readonly ComboBox _cboVehViaje = NuevoCombo();
    private readonly DataGridView _gridViajes = NuevaGrid();
    private readonly ComboBox _cboConductor = NuevoCombo(190);
    private readonly DateTimePicker _dtpViaje = new() { Format = DateTimePickerFormat.Short, Width = 110 };
    private readonly TextBox _txtOrigen = new() { Width = 130 };
    private readonly TextBox _txtDestino = new() { Width = 130 };
    private readonly NumericUpDown _nudKmIni = NuevoNumero(0, 10_000_000);
    private readonly NumericUpDown _nudKmFin = NuevoNumero(0, 10_000_000);
    private readonly NumericUpDown _nudLitros = NuevoNumero(0, 9999, 2);

    // --- Mantenimientos ---
    private readonly ComboBox _cboVehMant = NuevoCombo();
    private readonly DataGridView _gridMant = NuevaGrid();
    private readonly DateTimePicker _dtpMant = new() { Format = DateTimePickerFormat.Short, Width = 110 };
    private readonly ComboBox _cboTipo = NuevoCombo(110);
    private readonly TextBox _txtDescripcion = new() { Width = 260 };
    private readonly NumericUpDown _nudCosto = NuevoNumero(0, 9_999_999, 2);
    private readonly NumericUpDown _nudKmServicio = NuevoNumero(0, 10_000_000);

    public FormPrincipal()
    {
        Text = "Gestión de Flota - Cliente";
        Size = new Size(1000, 640);
        StartPosition = FormStartPosition.CenterScreen;

        _tabs.TabPages.Add(ConstruirTabVehiculos());
        _tabs.TabPages.Add(ConstruirTabViajes());
        _tabs.TabPages.Add(ConstruirTabMantenimientos());
        Controls.Add(_tabs);

        _cboTipo.Items.AddRange(new object[] { "Preventivo", "Correctivo" });
        _cboTipo.SelectedIndex = 0;

        _cboVehViaje.SelectedIndexChanged += (_, _) => CargarViajes();
        _cboVehMant.SelectedIndexChanged += (_, _) => CargarMantenimientos();

        Load += (_, _) => CargarCatalogos();
    }

    // ================= Construcción de pestañas =================

    private TabPage ConstruirTabVehiculos()
    {
        var tab = new TabPage("Vehículos");
        var btn = new Button { Text = "Actualizar", Dock = DockStyle.Top, Height = 32 };
        btn.Click += (_, _) => CargarCatalogos();
        tab.Controls.Add(_gridVehiculos);
        tab.Controls.Add(btn);
        return tab;
    }

    private TabPage ConstruirTabViajes()
    {
        var tab = new TabPage("Viajes");

        var arriba = new FlowLayoutPanel { Dock = DockStyle.Top, Height = 40, Padding = new Padding(5) };
        arriba.Controls.Add(new Label { Text = "Vehículo:", AutoSize = true, Margin = new Padding(0, 6, 3, 0) });
        arriba.Controls.Add(_cboVehViaje);

        var abajo = new FlowLayoutPanel { Dock = DockStyle.Bottom, Height = 110, Padding = new Padding(5) };
        AgregarCampo(abajo, "Conductor", _cboConductor);
        AgregarCampo(abajo, "Fecha", _dtpViaje);
        AgregarCampo(abajo, "Origen", _txtOrigen);
        AgregarCampo(abajo, "Destino", _txtDestino);
        AgregarCampo(abajo, "Km inicial", _nudKmIni);
        AgregarCampo(abajo, "Km final", _nudKmFin);
        AgregarCampo(abajo, "Litros", _nudLitros);
        var btn = new Button { Text = "Registrar viaje", Width = 120, Height = 28, Margin = new Padding(10, 18, 0, 0) };
        btn.Click += (_, _) => RegistrarViaje();
        abajo.Controls.Add(btn);

        tab.Controls.Add(_gridViajes);
        tab.Controls.Add(arriba);
        tab.Controls.Add(abajo);
        return tab;
    }

    private TabPage ConstruirTabMantenimientos()
    {
        var tab = new TabPage("Mantenimientos");

        var arriba = new FlowLayoutPanel { Dock = DockStyle.Top, Height = 40, Padding = new Padding(5) };
        arriba.Controls.Add(new Label { Text = "Vehículo:", AutoSize = true, Margin = new Padding(0, 6, 3, 0) });
        arriba.Controls.Add(_cboVehMant);

        var abajo = new FlowLayoutPanel { Dock = DockStyle.Bottom, Height = 110, Padding = new Padding(5) };
        AgregarCampo(abajo, "Fecha", _dtpMant);
        AgregarCampo(abajo, "Tipo", _cboTipo);
        AgregarCampo(abajo, "Descripción", _txtDescripcion);
        AgregarCampo(abajo, "Costo", _nudCosto);
        AgregarCampo(abajo, "Km servicio", _nudKmServicio);
        var btn = new Button { Text = "Registrar mantenimiento", Width = 160, Height = 28, Margin = new Padding(10, 18, 0, 0) };
        btn.Click += (_, _) => RegistrarMantenimiento();
        abajo.Controls.Add(btn);

        tab.Controls.Add(_gridMant);
        tab.Controls.Add(arriba);
        tab.Controls.Add(abajo);
        return tab;
    }

    // ================= Carga de datos =================

    private void CargarCatalogos(string? matViaje = null, string? matMant = null)
    {
        try
        {
            _gridVehiculos.DataSource = VehiculoDAO.Listar();

            _cboVehViaje.DisplayMember = "Matricula";
            _cboVehViaje.ValueMember = "Matricula";
            _cboVehViaje.DataSource = VehiculoDAO.Listar();
            if (matViaje != null) _cboVehViaje.SelectedValue = matViaje;

            _cboVehMant.DisplayMember = "Matricula";
            _cboVehMant.ValueMember = "Matricula";
            _cboVehMant.DataSource = VehiculoDAO.Listar();
            if (matMant != null) _cboVehMant.SelectedValue = matMant;

            _cboConductor.DisplayMember = "NombreCompleto";
            _cboConductor.ValueMember = "Cedula";
            _cboConductor.DataSource = ConductorDAO.Listar();
        }
        catch (Exception ex) { MostrarError(ex); }
    }

    private void CargarViajes()
    {
        if (_cboVehViaje.SelectedValue is not string mat) return;
        try
        {
            _gridViajes.DataSource = ViajeDAO.PorVehiculo(mat);
            if (_cboVehViaje.SelectedItem is DataRowView fila)
            {
                decimal km = Convert.ToDecimal(fila["Km_actual"]);
                _nudKmIni.Value = km;      // sugiere el km actual como inicio del viaje
                _nudKmFin.Value = km;
            }
        }
        catch (Exception ex) { MostrarError(ex); }
    }

    private void CargarMantenimientos()
    {
        if (_cboVehMant.SelectedValue is not string mat) return;
        try
        {
            _gridMant.DataSource = MantenimientoDAO.PorVehiculo(mat);
            if (_cboVehMant.SelectedItem is DataRowView fila)
                _nudKmServicio.Value = Convert.ToDecimal(fila["Km_actual"]);
        }
        catch (Exception ex) { MostrarError(ex); }
    }

    // ================= Acciones =================

    private void RegistrarViaje()
    {
        if (_cboVehViaje.SelectedValue is not string mat || _cboConductor.SelectedValue is not string ced)
        {
            Aviso("Seleccione un vehículo y un conductor.");
            return;
        }
        if (string.IsNullOrWhiteSpace(_txtOrigen.Text) || string.IsNullOrWhiteSpace(_txtDestino.Text))
        {
            Aviso("Escriba el origen y el destino.");
            return;
        }
        if (_nudKmFin.Value < _nudKmIni.Value)
        {
            Aviso("El kilometraje final no puede ser menor que el inicial.");
            return;
        }

        try
        {
            var viaje = new Viaje
            {
                Matricula = mat,
                Cedula = ced,
                Fecha = _dtpViaje.Value,
                Origen = _txtOrigen.Text.Trim(),
                Destino = _txtDestino.Text.Trim(),
                Km_inicial = (int)_nudKmIni.Value,
                Km_final = (int)_nudKmFin.Value,
                Litros_consumidos = _nudLitros.Value
            };

            int codigo = ViajeDAO.Registrar(viaje);
            MessageBox.Show($"Viaje registrado correctamente (código {codigo}).", "Listo",
                MessageBoxButtons.OK, MessageBoxIcon.Information);

            _txtOrigen.Clear();
            _txtDestino.Clear();
            CargarCatalogos(matViaje: mat);   // refresca también el Km actual del vehículo
        }
        catch (SqlException ex) { MostrarError(ex); }
    }

    private void RegistrarMantenimiento()
    {
        if (_cboVehMant.SelectedValue is not string mat)
        {
            Aviso("Seleccione un vehículo.");
            return;
        }
        if (string.IsNullOrWhiteSpace(_txtDescripcion.Text))
        {
            Aviso("Escriba la descripción del mantenimiento.");
            return;
        }

        try
        {
            var m = new Mantenimiento
            {
                Matricula = mat,
                Fecha = _dtpMant.Value,
                Tipo = _cboTipo.Text,
                Descripcion = _txtDescripcion.Text.Trim(),
                Costo = _nudCosto.Value,
                Km_servicio = (int)_nudKmServicio.Value
            };

            int codigo = MantenimientoDAO.Registrar(m);
            MessageBox.Show($"Mantenimiento registrado correctamente (código {codigo}).", "Listo",
                MessageBoxButtons.OK, MessageBoxIcon.Information);

            _txtDescripcion.Clear();
            CargarMantenimientos();
        }
        catch (SqlException ex) { MostrarError(ex); }
    }

    // ================= Utilidades de interfaz =================

    private static DataGridView NuevaGrid() => new()
    {
        Dock = DockStyle.Fill,
        ReadOnly = true,
        AllowUserToAddRows = false,
        AllowUserToDeleteRows = false,
        AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.AllCells,
        SelectionMode = DataGridViewSelectionMode.FullRowSelect
    };

    private static ComboBox NuevoCombo(int ancho = 140) =>
        new() { DropDownStyle = ComboBoxStyle.DropDownList, Width = ancho };

    private static NumericUpDown NuevoNumero(int min, int max, int decimales = 0) =>
        new() { Minimum = min, Maximum = max, DecimalPlaces = decimales, Width = 95 };

    private static void AgregarCampo(FlowLayoutPanel panel, string etiqueta, Control control)
    {
        var contenedor = new FlowLayoutPanel
        {
            FlowDirection = FlowDirection.TopDown,
            AutoSize = true,
            Margin = new Padding(0, 0, 8, 0)
        };
        contenedor.Controls.Add(new Label { Text = etiqueta, AutoSize = true });
        contenedor.Controls.Add(control);
        panel.Controls.Add(contenedor);
    }

    private static void Aviso(string texto) =>
        MessageBox.Show(texto, "Atención", MessageBoxButtons.OK, MessageBoxIcon.Warning);

    private static void MostrarError(Exception ex) =>
        MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
}
