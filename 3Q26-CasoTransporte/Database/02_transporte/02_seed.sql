/* =========================================================
   02_transporte / 02_seed.sql
   Datos de prueba para que ningún grupo dependa de otro:
   el grupo de Vehículos ya tiene propietarios, el de Multas
   ya tiene vehículos y tipos de multa, etc.
   Se puede ejecutar varias veces (no duplica registros).
   ========================================================= */
USE TransporteDB;
GO

/* Personas que serán propietarios */
IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Identificacion = '4-4444-4444')
  INSERT dbo.Personas (Identificacion, NombreCompleto, Correo) VALUES ('4-4444-4444', N'Ana Rodríguez', 'ana@mail.com');

IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Identificacion = '5-5555-5555')
  INSERT dbo.Personas (Identificacion, NombreCompleto, Correo) VALUES ('5-5555-5555', 'Luis Vargas', 'luis@mail.com');

IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Identificacion = '6-6666-6666')
  INSERT dbo.Personas (Identificacion, NombreCompleto, Correo) VALUES ('6-6666-6666', 'Transportes del Valle S.A.', 'info@delvalle.com');

DECLARE @IdAna   INT = (SELECT IdPersona FROM dbo.Personas WHERE Identificacion = '4-4444-4444');
DECLARE @IdLuis  INT = (SELECT IdPersona FROM dbo.Personas WHERE Identificacion = '5-5555-5555');
DECLARE @IdValle INT = (SELECT IdPersona FROM dbo.Personas WHERE Identificacion = '6-6666-6666');
/* Juan es usuario y también propietario: una misma persona puede tener ambos roles */
DECLARE @IdJuan  INT = (SELECT IdPersona FROM dbo.Personas WHERE Identificacion = '1-1111-1111');

IF NOT EXISTS (SELECT 1 FROM dbo.Propietarios WHERE IdPersona = @IdAna)
  INSERT dbo.Propietarios (IdPersona, Telefono, Direccion) VALUES (@IdAna, '8888-1111', N'San José, Escazú');

IF NOT EXISTS (SELECT 1 FROM dbo.Propietarios WHERE IdPersona = @IdLuis)
  INSERT dbo.Propietarios (IdPersona, Telefono, Direccion) VALUES (@IdLuis, '8888-2222', 'Heredia, Centro');

IF NOT EXISTS (SELECT 1 FROM dbo.Propietarios WHERE IdPersona = @IdValle)
  INSERT dbo.Propietarios (IdPersona, Telefono, Direccion) VALUES (@IdValle, '2222-3333', N'Cartago, Paraíso');

IF @IdJuan IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.Propietarios WHERE IdPersona = @IdJuan)
  INSERT dbo.Propietarios (IdPersona, Telefono, Direccion) VALUES (@IdJuan, '8888-4444', 'Alajuela, Centro');

/* Vehículos */
IF NOT EXISTS (SELECT 1 FROM dbo.Vehiculos WHERE Placa = 'ABC-123')
  INSERT dbo.Vehiculos (Placa, Marca, Modelo, IdPropietario) VALUES ('ABC-123', 'Toyota', 'Hilux', @IdAna);

IF NOT EXISTS (SELECT 1 FROM dbo.Vehiculos WHERE Placa = 'BCD-234')
  INSERT dbo.Vehiculos (Placa, Marca, Modelo, IdPropietario) VALUES ('BCD-234', 'Hyundai', 'H-100', @IdAna);

IF NOT EXISTS (SELECT 1 FROM dbo.Vehiculos WHERE Placa = 'CDE-345')
  INSERT dbo.Vehiculos (Placa, Marca, Modelo, IdPropietario) VALUES ('CDE-345', 'Isuzu', 'NPR', @IdLuis);

IF NOT EXISTS (SELECT 1 FROM dbo.Vehiculos WHERE Placa = 'DEF-456')
  INSERT dbo.Vehiculos (Placa, Marca, Modelo, IdPropietario) VALUES ('DEF-456', 'Mercedes-Benz', 'Sprinter', @IdValle);

IF NOT EXISTS (SELECT 1 FROM dbo.Vehiculos WHERE Placa = 'EFG-567')
  INSERT dbo.Vehiculos (Placa, Marca, Modelo, IdPropietario) VALUES ('EFG-567', 'Nissan', 'Frontier', @IdValle);

/* Tipos de multa (montos de ejemplo) */
IF NOT EXISTS (SELECT 1 FROM dbo.TiposMulta WHERE Descripcion = 'Exceso de velocidad')
  INSERT dbo.TiposMulta (Descripcion, MontoBase, Activa) VALUES ('Exceso de velocidad', 75000.00, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.TiposMulta WHERE Descripcion = 'Estacionamiento prohibido')
  INSERT dbo.TiposMulta (Descripcion, MontoBase, Activa) VALUES ('Estacionamiento prohibido', 25000.00, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.TiposMulta WHERE Descripcion = N'Revisión técnica vencida')
  INSERT dbo.TiposMulta (Descripcion, MontoBase, Activa) VALUES (N'Revisión técnica vencida', 50000.00, 1);

/* Tipo inactivo: no debe aparecer al registrar multas nuevas */
IF NOT EXISTS (SELECT 1 FROM dbo.TiposMulta WHERE Descripcion = 'Uso de celular (tarifa anterior)')
  INSERT dbo.TiposMulta (Descripcion, MontoBase, Activa) VALUES ('Uso de celular (tarifa anterior)', 30000.00, 0);

/* Multas de ejemplo (solo si la tabla está vacía) */
IF NOT EXISTS (SELECT 1 FROM dbo.Multas)
BEGIN
  INSERT dbo.Multas (IdVehiculo, IdTipoMulta, Fecha, MontoAplicado, Pagada)
  SELECT v.IdVehiculo, t.IdTipoMulta, '2026-10-05 08:30', t.MontoBase, 0
  FROM dbo.Vehiculos v CROSS JOIN dbo.TiposMulta t
  WHERE v.Placa = 'ABC-123' AND t.Descripcion = 'Exceso de velocidad';

  INSERT dbo.Multas (IdVehiculo, IdTipoMulta, Fecha, MontoAplicado, Pagada)
  SELECT v.IdVehiculo, t.IdTipoMulta, '2026-10-12 14:10', t.MontoBase, 1
  FROM dbo.Vehiculos v CROSS JOIN dbo.TiposMulta t
  WHERE v.Placa = 'ABC-123' AND t.Descripcion = 'Estacionamiento prohibido';

  INSERT dbo.Multas (IdVehiculo, IdTipoMulta, Fecha, MontoAplicado, Pagada)
  SELECT v.IdVehiculo, t.IdTipoMulta, '2026-10-20 10:00', t.MontoBase, 0
  FROM dbo.Vehiculos v CROSS JOIN dbo.TiposMulta t
  WHERE v.Placa = 'DEF-456' AND t.Descripcion = N'Revisión técnica vencida';

  /* Multa con un monto distinto al MontoBase actual (la tarifa cambió después) */
  INSERT dbo.Multas (IdVehiculo, IdTipoMulta, Fecha, MontoAplicado, Pagada)
  SELECT v.IdVehiculo, t.IdTipoMulta, '2026-09-15 17:45', 22000.00, 1
  FROM dbo.Vehiculos v CROSS JOIN dbo.TiposMulta t
  WHERE v.Placa = 'CDE-345' AND t.Descripcion = 'Uso de celular (tarifa anterior)';
END
GO
