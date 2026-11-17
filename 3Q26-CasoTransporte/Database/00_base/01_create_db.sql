/* =========================================================
   00_base / 01_create_db.sql
   Crea la base de datos TransporteDB si no existe.
   Ejecutar primero, conectado a la instancia (master).
   ========================================================= */
USE master;
GO

IF DB_ID('TransporteDB') IS NULL
BEGIN
  CREATE DATABASE TransporteDB;
END
GO
