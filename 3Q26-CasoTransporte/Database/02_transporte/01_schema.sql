/* =========================================================
   02_transporte / 01_schema.sql
   Tablas de los módulos que desarrollan los grupos.
   Se entregan creadas para que todos los grupos trabajen
   sobre la misma estructura y puedan avanzar en paralelo.
   ========================================================= */
USE TransporteDB;
GO

/* PROPIETARIOS (1:1 con Personas) - Grupo A */
IF OBJECT_ID('dbo.Propietarios', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.Propietarios (
    IdPersona INT NOT NULL PRIMARY KEY, -- PK y FK: garantiza la relación 1:1
    Telefono  NVARCHAR(20)  NULL,
    Direccion NVARCHAR(200) NULL,

    CONSTRAINT FK_Propietarios_Personas
      FOREIGN KEY (IdPersona) REFERENCES dbo.Personas(IdPersona)
      ON DELETE CASCADE
  );
END
GO

/* VEHICULOS (N:1 con Propietarios) - Grupo B */
IF OBJECT_ID('dbo.Vehiculos', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.Vehiculos (
    IdVehiculo    INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Placa         NVARCHAR(15) NOT NULL,
    Marca         NVARCHAR(50) NOT NULL,
    Modelo        NVARCHAR(50) NOT NULL,
    IdPropietario INT NOT NULL,

    CONSTRAINT FK_Vehiculos_Propietarios
      FOREIGN KEY (IdPropietario) REFERENCES dbo.Propietarios(IdPersona)
  );

  CREATE UNIQUE INDEX UX_Vehiculos_Placa ON dbo.Vehiculos(Placa);
END
GO

/* TIPOS DE MULTA (catálogo) - Grupo C */
IF OBJECT_ID('dbo.TiposMulta', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.TiposMulta (
    IdTipoMulta INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Descripcion NVARCHAR(150) NOT NULL,
    MontoBase   DECIMAL(12,2) NOT NULL,
    Activa      BIT NOT NULL CONSTRAINT DF_TiposMulta_Activa DEFAULT (1),

    CONSTRAINT CK_TiposMulta_MontoBase CHECK (MontoBase > 0)
  );

  CREATE UNIQUE INDEX UX_TiposMulta_Descripcion ON dbo.TiposMulta(Descripcion);
END
GO

/* MULTAS (N:1 con Vehiculos y con TiposMulta) - Grupo D */
IF OBJECT_ID('dbo.Multas', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.Multas (
    IdMulta       INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    IdVehiculo    INT NOT NULL,
    IdTipoMulta   INT NOT NULL,
    Fecha         DATETIME2(0) NOT NULL CONSTRAINT DF_Multas_Fecha DEFAULT (SYSDATETIME()),
    MontoAplicado DECIMAL(12,2) NOT NULL, -- copia del MontoBase vigente al registrar la multa
    Pagada        BIT NOT NULL CONSTRAINT DF_Multas_Pagada DEFAULT (0),

    CONSTRAINT CK_Multas_MontoAplicado CHECK (MontoAplicado > 0),
    CONSTRAINT FK_Multas_Vehiculos
      FOREIGN KEY (IdVehiculo) REFERENCES dbo.Vehiculos(IdVehiculo),
    CONSTRAINT FK_Multas_TiposMulta
      FOREIGN KEY (IdTipoMulta) REFERENCES dbo.TiposMulta(IdTipoMulta)
  );
END
GO
