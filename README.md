# GestionFlota - Grupo 3 (Aplicaciones cliente-servidor, C#)

Sistema de gestión de flota: vehículos, conductores, viajes y mantenimientos.
Arquitectura en capas: Presentación (Windows Forms) → Acceso a datos (DAO) → Procedimientos almacenados → SQL Server.

## Cómo ejecutarlo
1. En SSMS abrir y ejecutar `SQL/00_GestionFlota.sql`.
   **OJO:** este script borra y recrea la base `GestionFlota`. No volver a ejecutarlo
   después de crear los procedimientos, o se pierden (si pasa, ejecutar 01 y 02 otra vez).
2. Ejecutar `SQL/01_SP_Consulta.sql` y luego `SQL/02_SP_Escritura.sql`.
3. Copiar `appsettings.example.json` a `appsettings.json` y poner el nombre de **tu** servidor
   (por ejemplo `localhost`, `.\\SQLEXPRESS` o `TU-PC\\SQLEXPRESS`). Este archivo no se sube a Git.
4. Abrir `GestionFlota.csproj` en Visual Studio 2022 (SDK .NET 8) y presionar F5.

## Responsables y archivos
| Persona | Parte | Archivos |
|---|---|---|
| P1 | Base de datos y proyecto base | `SQL/00_GestionFlota.sql`, `GestionFlota.csproj`, `Program.cs` |
| P2 | Cadena de conexión | `appsettings.example.json`, `Datos/Conexion.cs` |
| P3 | SP de consulta | `SQL/01_SP_Consulta.sql` |
| P4 | SP de escritura | `SQL/02_SP_Escritura.sql` |
| P5 | Acceso a datos | `Modelos/Modelos.cs`, `Datos/DataHelper.cs`, `Datos/*DAO.cs` |
| P6 | Cliente | `Presentacion/FormPrincipal.cs` |

## Reglas del equipo
- Cada quien edita solo sus archivos.
- Siempre `git pull` antes de `git push`.
