USE TransporteDB;
GO

/* PROPIETARIOS (1:1 with Personas) */
IF OBJECT_ID('dbo.Propietarios', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.Propietarios (
    IdPersona INT NOT NULL PRIMARY KEY, -- PK/FK enforces 1:1
    Telefono NVARCHAR(20) NULL,
    Direccion NVARCHAR(200) NULL,

    CONSTRAINT FK_Propietarios_Personas
      FOREIGN KEY (IdPersona) REFERENCES dbo.Personas(IdPersona)
      ON DELETE CASCADE
  );
END
GO