USE TransporteDB;
GO

/* PERSONAS */
IF OBJECT_ID('dbo.Personas', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.Personas (
    IdPersona INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    NombreCompleto NVARCHAR(120) NOT NULL,
    Identificacion NVARCHAR(30) NOT NULL,
    Correo NVARCHAR(120) NULL
  );

  CREATE UNIQUE INDEX UX_Personas_Identificacion ON dbo.Personas(Identificacion);
END
GO

/* USUARIOS (1:1 with Personas) */
IF OBJECT_ID('dbo.Usuarios', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.Usuarios (
    IdPersona INT NOT NULL PRIMARY KEY, -- PK/FK enforces 1:1
    Username NVARCHAR(60) NOT NULL,
    PasswordHash NVARCHAR(200) NOT NULL,
    Rol NVARCHAR(30) NOT NULL,
    Activo BIT NOT NULL CONSTRAINT DF_Usuarios_Activo DEFAULT (1),

    CONSTRAINT FK_Usuarios_Personas
      FOREIGN KEY (IdPersona) REFERENCES dbo.Personas(IdPersona)
      ON DELETE CASCADE
  );

  CREATE UNIQUE INDEX UX_Usuarios_Username ON dbo.Usuarios(Username);
END
GO