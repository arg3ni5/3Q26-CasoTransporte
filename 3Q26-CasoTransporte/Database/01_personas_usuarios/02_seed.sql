USE TransporteDB;
GO

/* Minimal seed (idempotent-ish using Identificacion/Username uniqueness) */
IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Identificacion = '1-1111-1111')
  INSERT dbo.Personas (NombreCompleto, Identificacion, Correo)
  VALUES ('Juan Perez', '1-1111-1111', 'juan@mail.com');

IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Identificacion = '2-2222-2222')
  INSERT dbo.Personas (NombreCompleto, Identificacion, Correo)
  VALUES ('Maria Lopez', '2-2222-2222', 'maria@mail.com');

IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Identificacion = '3-3333-3333')
  INSERT dbo.Personas (NombreCompleto, Identificacion, Correo)
  VALUES ('Carlos Mora', '3-3333-3333', 'carlos@mail.com');

DECLARE @IdJuan INT = (SELECT TOP 1 IdPersona FROM dbo.Personas WHERE Identificacion = '1-1111-1111');
DECLARE @IdMaria INT = (SELECT TOP 1 IdPersona FROM dbo.Personas WHERE Identificacion = '2-2222-2222');
DECLARE @IdCarlos INT = (SELECT TOP 1 IdPersona FROM dbo.Personas WHERE Identificacion = '3-3333-3333');

IF NOT EXISTS (SELECT 1 FROM dbo.Usuarios WHERE Username = 'juan')
  INSERT dbo.Usuarios (IdPersona, Username, PasswordHash, Rol, Activo)
  VALUES (@IdJuan, 'juan', 'HASH_PLACEHOLDER', 'admin', 1);

IF NOT EXISTS (SELECT 1 FROM dbo.Usuarios WHERE Username = 'maria')
  INSERT dbo.Usuarios (IdPersona, Username, PasswordHash, Rol, Activo)
  VALUES (@IdMaria, 'maria', 'HASH_PLACEHOLDER', 'user', 1);

IF NOT EXISTS (SELECT 1 FROM dbo.Usuarios WHERE Username = 'carlos')
  INSERT dbo.Usuarios (IdPersona, Username, PasswordHash, Rol, Activo)
  VALUES (@IdCarlos, 'carlos', 'HASH_PLACEHOLDER', 'user', 1);
GO