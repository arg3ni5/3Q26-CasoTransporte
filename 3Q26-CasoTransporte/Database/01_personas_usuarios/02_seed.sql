/* =========================================================
   01_personas_usuarios / 02_seed.sql
   Usuarios de prueba. Contraseña de todos: Clave123
   Se puede ejecutar varias veces (no duplica registros).
   ========================================================= */
USE TransporteDB;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Identificacion = '1-1111-1111')
  INSERT dbo.Personas (Identificacion, NombreCompleto, Correo)
  VALUES ('1-1111-1111', N'Juan Pérez', 'juan@mail.com');

IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Identificacion = '2-2222-2222')
  INSERT dbo.Personas (Identificacion, NombreCompleto, Correo)
  VALUES ('2-2222-2222', N'María López', 'maria@mail.com');

IF NOT EXISTS (SELECT 1 FROM dbo.Personas WHERE Identificacion = '3-3333-3333')
  INSERT dbo.Personas (Identificacion, NombreCompleto, Correo)
  VALUES ('3-3333-3333', 'Carlos Mora', 'carlos@mail.com');

DECLARE @IdJuan   INT = (SELECT IdPersona FROM dbo.Personas WHERE Identificacion = '1-1111-1111');
DECLARE @IdMaria  INT = (SELECT IdPersona FROM dbo.Personas WHERE Identificacion = '2-2222-2222');
DECLARE @IdCarlos INT = (SELECT IdPersona FROM dbo.Personas WHERE Identificacion = '3-3333-3333');

/* Hashes generados con PBKDF2-SHA256 (100000 iteraciones) para la contraseña "Clave123" */
IF NOT EXISTS (SELECT 1 FROM dbo.Usuarios WHERE Username = 'juan')
  INSERT dbo.Usuarios (IdPersona, Username, PasswordHash, Rol, Activo)
  VALUES (@IdJuan, 'juan', '100000.hKA7ptROB4dHr5xCK6G+rQ==.NyGYuyyAjZM/6UmAu7ma0Wf9CyrBd5BGdPDBQ+78b5U=', 'Administrador', 1);

IF NOT EXISTS (SELECT 1 FROM dbo.Usuarios WHERE Username = 'maria')
  INSERT dbo.Usuarios (IdPersona, Username, PasswordHash, Rol, Activo)
  VALUES (@IdMaria, 'maria', '100000.NwnW9LlNgZw3wRa/E3ZwOA==.WxqP32yxww//mvym22BSIPglbRhg8wx044TGNxN9pNw=', 'Operador', 1);

/* Carlos está inactivo: sirve para probar que un usuario inactivo no puede ingresar */
IF NOT EXISTS (SELECT 1 FROM dbo.Usuarios WHERE Username = 'carlos')
  INSERT dbo.Usuarios (IdPersona, Username, PasswordHash, Rol, Activo)
  VALUES (@IdCarlos, 'carlos', '100000.YX61HgFb1JesnJW0FehuMQ==.1oO6C/JknjxPZznOYJoQdYHCyUtFvbazPeV4cGtUs3E=', 'Operador', 0);
GO
