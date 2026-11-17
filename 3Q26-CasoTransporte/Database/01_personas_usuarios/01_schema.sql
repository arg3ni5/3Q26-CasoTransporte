/* =========================================================
   01_personas_usuarios / 01_schema.sql
   Tablas base del proyecto (las entrega el docente).
   Personas es la tabla "padre"; Usuarios y Propietarios
   son especializaciones 1:1 (comparten IdPersona como PK y FK).
   ========================================================= */
USE TransporteDB;
GO

/* PERSONAS */
IF OBJECT_ID('dbo.Personas', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.Personas (
    IdPersona      INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Identificacion NVARCHAR(30)  NOT NULL,
    NombreCompleto NVARCHAR(120) NOT NULL,
    Correo         NVARCHAR(120) NULL
  );

  CREATE UNIQUE INDEX UX_Personas_Identificacion ON dbo.Personas(Identificacion);
END
GO

/* USUARIOS (1:1 con Personas) */
IF OBJECT_ID('dbo.Usuarios', 'U') IS NULL
BEGIN
  CREATE TABLE dbo.Usuarios (
    IdPersona    INT NOT NULL PRIMARY KEY, -- PK y FK: garantiza la relación 1:1
    Username     NVARCHAR(60)  NOT NULL,
    PasswordHash NVARCHAR(200) NOT NULL,   -- formato: iteraciones.salt.hash (PBKDF2-SHA256, ver Utils/PasswordHasher.vb)
    Rol          NVARCHAR(30)  NOT NULL CONSTRAINT DF_Usuarios_Rol DEFAULT ('Operador'),
    Activo       BIT NOT NULL CONSTRAINT DF_Usuarios_Activo DEFAULT (1),

    CONSTRAINT CK_Usuarios_Rol CHECK (Rol IN ('Administrador', 'Operador')),
    CONSTRAINT FK_Usuarios_Personas
      FOREIGN KEY (IdPersona) REFERENCES dbo.Personas(IdPersona)
      ON DELETE CASCADE
  );

  CREATE UNIQUE INDEX UX_Usuarios_Username ON dbo.Usuarios(Username);
END
GO
