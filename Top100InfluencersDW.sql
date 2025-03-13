-- Crear Data Warehouse
CREATE DATABASE Top100InfluencersDW;
GO

USE Top100InfluencersDW;
GO

-- Crear Tablas Staging (STG)
CREATE TABLE stg_Genero (
    Id_Genero INT NOT NULL,
    Genero VARCHAR(50) NOT NULL
);
CREATE TABLE stg_Categoria (
    Id_Categoria INT NOT NULL,
    Categoria VARCHAR(100) NOT NULL
);
CREATE TABLE stg_Audiencia (
    Id_Audiencia INT NOT NULL,
    País_Audiencia VARCHAR(100) NOT NULL
);
CREATE TABLE stg_Residencia (
    Id_Residencia INT NOT NULL,
    Residencia VARCHAR(100) NOT NULL
);
CREATE TABLE stg_Interacciones (
    Id_Interacciones INT NOT NULL,
    Seguidos INT NOT NULL,
    Seguidores INT NOT NULL,
    Total_interacciones INT NOT NULL,
    Engagement_avg INT NOT NULL
);
CREATE TABLE stg_Usuarios (
    Id_Usuario INT NOT NULL,
    Titulo VARCHAR(100) NOT NULL,
    Usuario VARCHAR(100) NOT NULL,
    Fecha_Creacion DATE NOT NULL,
    Id_Interacciones INT NOT NULL,
    Id_Genero INT NOT NULL,
    Id_Categoria INT NOT NULL,
    Id_Audiencia INT NOT NULL,
    Id_Residencia INT NOT NULL
);
GO

-- Crear Tablas Intermedias (INT) 
SELECT Id_Interacciones, Seguidos, Seguidores, Total_interacciones, Engagement_avg, ROW_NUMBER() OVER (ORDER BY Id_Interacciones) AS RowNumber
INTO int_Interacciones
FROM stg_Interacciones;

SELECT Id_Genero, Genero, ROW_NUMBER() OVER (ORDER BY Id_Genero) AS RowNumber
INTO int_Genero
FROM stg_Genero;

SELECT Id_Categoria, Categoria, ROW_NUMBER() OVER (ORDER BY Id_Categoria) AS RowNumber
INTO int_Categoria
FROM stg_Categoria;

SELECT Id_Audiencia, País_Audiencia, ROW_NUMBER() OVER (ORDER BY Id_Audiencia) AS RowNumber
INTO int_Audiencia
FROM stg_Audiencia;

SELECT Id_Residencia, Residencia, ROW_NUMBER() OVER (ORDER BY Id_Residencia) AS RowNumber
INTO int_Residencia
FROM stg_Residencia;
GO

SELECT Id_Usuario, Titulo, Usuario, Fecha_Creacion, Id_Interacciones, Id_Genero, Id_Categoria, Id_Audiencia, Id_Residencia, ROW_NUMBER() OVER (ORDER BY Id_Usuario) AS RowNumber
INTO int_Usuarios
FROM stg_Usuarios;

-- Crear Tablas Finales
CREATE TABLE dbo.Genero (
    Id_Genero INT PRIMARY KEY NOT NULL,
    Genero VARCHAR(50) NOT NULL
);

CREATE TABLE dbo.Categoria (
    Id_Categoria INT PRIMARY KEY NOT NULL,
    Categoria VARCHAR(100) NOT NULL
);

CREATE TABLE dbo.Audiencia (
    Id_Audiencia INT PRIMARY KEY NOT NULL,
    País_Audiencia VARCHAR(100) NOT NULL
);

CREATE TABLE dbo.Residencia (
    Id_Residencia INT PRIMARY KEY NOT NULL,
    Residencia VARCHAR(100) NOT NULL
);

CREATE TABLE dbo.Interacciones (
    Id_Interacciones INT PRIMARY KEY NOT NULL,
    Seguidos INT NOT NULL,
    Seguidores INT NOT NULL,
    Total_interacciones INT NOT NULL,
    Engagement_avg INT NOT NULL
);

CREATE TABLE dbo.Usuarios (
    Id_Usuario INT PRIMARY KEY NOT NULL,
    Titulo VARCHAR(100) NOT NULL,
    Usuario VARCHAR(100) NOT NULL UNIQUE,
    Fecha_Creacion DATE NOT NULL,
    Id_Interacciones INT NOT NULL,
    Id_Genero INT NOT NULL,
    Id_Categoria INT NOT NULL,
    Id_Audiencia INT NOT NULL,
    Id_Residencia INT NOT NULL,
    FOREIGN KEY (Id_Interacciones) REFERENCES dbo.Interacciones(Id_Interacciones),
    FOREIGN KEY (Id_Genero) REFERENCES dbo.Genero(Id_Genero),
    FOREIGN KEY (Id_Categoria) REFERENCES dbo.Categoria(Id_Categoria),
    FOREIGN KEY (Id_Audiencia) REFERENCES dbo.Audiencia(Id_Audiencia),
    FOREIGN KEY (Id_Residencia) REFERENCES dbo.Residencia(Id_Residencia)
);
GO

-- Cargar Tablas STG 
BULK INSERT stg_Genero
FROM 'C:\Users\Positivo BGH\OneDrive\Escritorio\genero.csv'
WITH (
    FIELDTERMINATOR = ';',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2
);
GO

BULK INSERT stg_Categoria
FROM 'C:\Users\Positivo BGH\OneDrive\Escritorio\categoria.csv'
WITH (
    FIELDTERMINATOR = ';',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2
);
GO

BULK INSERT stg_Audiencia
FROM 'C:\Users\Positivo BGH\OneDrive\Escritorio\audiencia.csv'
WITH (
    FIELDTERMINATOR = ';',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2
);
GO

BULK INSERT stg_Residencia
FROM 'C:\Users\Positivo BGH\OneDrive\Escritorio\residencia.csv'
WITH (
    FIELDTERMINATOR = ';',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2
);
GO

BULK INSERT stg_Interacciones
FROM 'C:\Users\Positivo BGH\OneDrive\Escritorio\interacciones.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n', 
    FIRSTROW = 2
);
GO

BULK INSERT stg_Usuarios
FROM 'C:\Users\Positivo BGH\OneDrive\Escritorio\usuarios.csv'
WITH (
    FIELDTERMINATOR = ';',  
    ROWTERMINATOR = '\n',  
    FIRSTROW = 2
);
GO

-- Cargar Tablas INT
INSERT INTO int_Interacciones (Id_Interacciones, Seguidos, Seguidores, Total_interacciones, Engagement_avg)
SELECT Id_Interacciones, Seguidos, Seguidores, Total_interacciones, Engagement_avg
FROM stg_Interacciones
ORDER BY Id_Interacciones;
GO

INSERT INTO int_Genero (Id_Genero, Genero)
SELECT DISTINCT Id_Genero, Genero
FROM stg_Genero
ORDER BY Id_Genero;
GO

INSERT INTO int_Categoria (Id_Categoria, Categoria)
SELECT DISTINCT Id_Categoria, Categoria
FROM stg_Categoria
ORDER BY Id_Categoria;
GO

INSERT INTO int_Audiencia (Id_Audiencia, País_Audiencia)
SELECT DISTINCT Id_Audiencia, País_Audiencia
FROM stg_Audiencia
ORDER BY Id_Audiencia;
GO

INSERT INTO int_Residencia (Id_Residencia, Residencia)
SELECT DISTINCT Id_Residencia, Residencia
FROM stg_Residencia
ORDER BY Id_Residencia;
GO

INSERT INTO int_Usuarios (Id_Usuario, Titulo, Usuario, Fecha_Creacion, Id_Interacciones, Id_Genero, Id_Categoria, Id_Audiencia, Id_Residencia)
SELECT Id_Usuario, Titulo, Usuario, Fecha_Creacion, Id_Interacciones, Id_Genero, Id_Categoria, Id_Audiencia, Id_Residencia
FROM stg_Usuarios 
ORDER BY Id_Usuario;
GO

-- Cargar Tablas Finales
INSERT INTO dbo.Genero (Id_Genero, Genero)
SELECT Id_Genero, Genero
FROM int_Genero
ORDER BY Id_Genero;
GO

INSERT INTO dbo.Categoria (Id_Categoria, Categoria)
SELECT Id_Categoria, Categoria
FROM int_Categoria
ORDER BY Id_Categoria;
GO

INSERT INTO dbo.Audiencia (Id_Audiencia, País_Audiencia)
SELECT Id_Audiencia, País_Audiencia
FROM int_Audiencia
ORDER BY Id_Audiencia;
GO

INSERT INTO dbo.Residencia (Id_Residencia, Residencia)
SELECT Id_Residencia, Residencia
FROM int_Residencia
ORDER BY Id_Residencia;
GO

INSERT INTO dbo.Interacciones (Id_Interacciones, Seguidos, Seguidores, Total_interacciones, Engagement_avg)
SELECT Id_Interacciones, Seguidos, Seguidores, Total_interacciones, Engagement_avg
FROM int_Interacciones
ORDER BY Id_Interacciones;
GO

INSERT INTO dbo.Interacciones (Id_Interacciones, Seguidos, Seguidores, Total_interacciones, Engagement_avg)
SELECT Id_Interacciones, Seguidos, Seguidores, Total_interacciones, Engagement_avg
FROM int_Usuarios
ORDER BY Id_Interacciones;
GO

INSERT INTO dbo.Usuarios (Id_Usuario, Titulo, Usuario, Fecha_Creacion, Id_Interacciones, Id_Genero, Id_Categoria, Id_Audiencia, Id_Residencia)
SELECT Id_Usuario, Titulo, Usuario, Fecha_Creacion, Id_Interacciones, Id_Genero, Id_Categoria, Id_Audiencia, Id_Residencia
FROM int_Usuarios 
ORDER BY Id_Usuario;
GO

-- Verificacion
SELECT * FROM dbo.Audiencia;
SELECT * FROM dbo.Categoria
SELECT * FROM dbo.Genero
SELECT * FROM dbo.Residencia
SELECT * FROM dbo.Interacciones
SELECT * FROM dbo.Usuarios