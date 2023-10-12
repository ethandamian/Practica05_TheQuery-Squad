/*
Script para la creación de la base de datos de El Zoologico de Huitziltepec
*/

DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE TABLE Servicio(
	IDServicio serial NOT NULL CHECK( IDServicio > 0),
	TipoServicio VARCHAR(20) NOT NULL CHECK(TipoServicio IN ('baño','tienda','comida')),
	PRIMARY KEY (IDServicio)
);

CREATE TABLE TelefonoVisitante(
	IDVisitante serial NOT NULL CHECK (IDVisitante > 0),
	Telefono CHAR(10) NOT NULL CHECK(Telefono SIMILAR TO '[0-9]+'),
	PRIMARY KEY(IDVisitante, Telefono)
);

CREATE TABLE TelefonoProveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK(LENGTH(RFCProveedor) = 13 OR LENGTH(RFCProveedor) = 12 AND RFCProveedor LIKE '^[A-Z]{4}[0-9]{6}[A-Z0-9]{0,3}$'),
	Telefono CHAR(10) NOT NULL CHECK(Telefono SIMILAR TO '[0-9]+'),
	PRIMARY KEY(RFCProveedor, Telefono)
);

CREATE TABLE CorreoProveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK(LENGTH(RFCProveedor) = 13 OR LENGTH(RFCProveedor) = 12 AND RFCProveedor LIKE '^[A-Z]{4}[0-9]{6}[A-Z0-9]{0,3}$'),
	Correo VARCHAR(50) NOT NULL CHECK(Correo LIKE '%_@_%._%' ),
	PRIMARY KEY(RFCProveedor, Correo)
);

CREATE TABLE ProveerMedicina(
	IDInsumoMedicina serial NOT NULL CHECK(IDInsumoMedicina > 0),
	RFCProveedor VARCHAR(13) NOT NULL CHECK(LENGTH(RFCProveedor) = 13 OR LENGTH(RFCProveedor) = 12 AND RFCProveedor LIKE '^[A-Z]{4}[0-9]{6}[A-Z0-9]{0,3}$')
	RFCProveedor VARCHAR(13) NOT NULL CHECK(RFCProveedor <> '')
);

--------TABLAS CON LLAVES PRIMARIAS-----------------
CREATE TABLE CorreoVeterinario(
	RFCVeterinario VARCHAR(13) CHECK(RFCVeterinario <> '' AND (LENGTH(RFCVeterinario = 13) OR LENGTH(RFCVeterinario = 12))),
	Correo VARCHAR(50)  CHECK (Correo LIKE '%_@_%._%' AND Correo <> ''),
	PRIMARY KEY(RFCVeterinario,Correo)
);

CREATE TABLE TelefonoVeterinario(
	RFCVeterinario VARCHAR(13) CHECK(RFCVeterinario <> '' AND (LENGTH(RFCVeterinario = 13) OR LENGTH(RFCVeterinario = 12) )),
	Telefono CHAR(10) CHECK(Telefono ~ '^[0-9 ]*$' AND Telefono <> ''),
	PRIMARY KEY(RFCVeterinario,Telefono)

);

------------------------------PARTE ETHAN -----------------------------------------------
CREATE TABLE Notificar(
	idEvento INT NOT NULL,
	IDVisitante INT NOT NULL,
	TipoNotificacion VARCHAR(50) NOT NULL CHECK (TipoNotificacion <> '')
	FOREIGN KEY (idEvento) REFERENCES Evento(idEvento),
	FOREIGN KEY (IDVisitante) REFERENCES Visitante(IDVisitante)

);

CREATE TABLE Veterinario(
	RFCVeterinario VARCHAR(13) NOT NULL CHECK 
										(RFCVeterinario <> '', AND 
										 (LENGTH(RFCVeterinario = 13) OR 
										  LENGTH(RFCVeterinario = 12) ) AND 
										LEFT(RFCVeterinario,4) LIKE '%[A-Z]%' AND
										RIGHT(RFCVeterinario,6) ~ '^[0-9 ]*$'),
	Nombre VARCHAR(50) NOT NULL CHECK(Nombre <> '' AND Nombre LIKE '%[a-zA-Z]%'\),
	ApellidoPaterno VARCHAR(50) NOT NULL CHECK(ApellidoPaterno <> '' AND ApellidoPaterno LIKE '%[a-zA-Z]%'),
	ApellidoMaterno VARCHAR(50) NOT NULL CHECK(ApellidoMaterno <> '' AND ApellidoMaterno LIKE '%[a-zA-Z]%'),
	Calle VARCHAR(50) NOT NULL CHECK(Calle <> ''),
	NumInterior INT NOT NULL,
	NumExterior INT NOT NULL,
	Colonia VARCHAR(50) NOT NULL CHECK(Colonia <> ''),
	Estado VARCHAR(50) NOT NULL CHECK(Estado <> '' AND Estado LIKE '%[a-zA-Z]%'),
	FechaInicioContrato DATE NOT NULL,
	FechaFinContrato DATE NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Genero VARCHAR(10) NOT NULL CHECK(Genero <> '' AND Genero LIKE '%[a-zA-Z]%'),
	Salario DECIMAL NOT NULL CHECK(Salario > 0),
	Especialidad VARCHAR(50) NOT NULL CHECK(Especialidad <> '' AND Especialidad LIKE '%[a-zA-Z]%')
	PRIMARY KEY(RFCVeterinario)
	
);


CREATE TABLE Proveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK 
										(RFCProveedor <> '', AND 
										 (LENGTH(RFCProveedor = 13) OR 
										  LENGTH(RFCProveedor = 12) ) AND 
										LEFT(RFCProveedor,4) LIKE '%[A-Z]%' AND
										RIGHT(RFCProveedor,6) ~ '^[0-9 ]*$'),
	Nombre VARCHAR(50) NOT NULL CHECK(Nombre <> '' AND Nombre LIKE '%[a-zA-Z]%'),
	ApellidoPaterno VARCHAR(50) NOT NULL CHECK(ApellidoPaterno <> '' AND ApellidoPaterno LIKE '%[a-zA-Z]%'),
	ApellidoMaterno VARCHAR(50) NOT NULL CHECK(ApellidoMaterno <> '' AND ApellidoMaterno LIKE '%[a-zA-Z]%'),
	Calle VARCHAR(50) NOT NULL CHECK(Calle <> ''),
	NumInterior INT NOT NULL,
	NumExterior INT NOT NULL,
	Colonia VARCHAR(50) NOT NULL CHECK(Colonia <> ''),
	Estado VARCHAR(50) NOT NULL CHECK(Estado <> '' AND Estado LIKE '%[a-zA-Z]%'),
	FechaInicioContrato DATE NOT NULL,
	FechaFinContrato DATE NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Genero VARCHAR(10) NOT NULL CHECK(Genero <> '' AND Genero LIKE '%[a-zA-Z]%'),
	FrecuenciaServicio INT NOT NULL CHECK(FrecuenciaServicio > 0),
	CostoServicio INT NOT NULL CHECK(CostoServicio > 0),
	PRIMARY KEY(RFCProveedor)
	
);


CREATE TABLE Cuidador(
	RFCCuidador VARCHAR(13) NOT NULL CHECK 
										(RFCCuidador <> '', AND 
										 (LENGTH(RFCCuidador = 13) OR 
										  LENGTH(RFCCuidador = 12) ) AND 
										LEFT(RFCCuidador,4) LIKE '%[A-Z]%' AND
										RIGHT(RFCCuidador,6) ~ '^[0-9 ]*$'),
	IDBioma INT NOT NULL, 
	Nombre VARCHAR(50) NOT NULL CHECK(Nombre <> '' AND Nombre LIKE '%[a-zA-Z]%'),
	ApellidoPaterno VARCHAR(50) CHECK(ApellidoPaterno <> '' AND ApellidoPaterno LIKE '%[a-zA-Z]%'),
	ApellidoMaterno VARCHAR(50) CHECK(ApellidoMaterno <> '' AND ApellidoMaterno LIKE '%[a-zA-Z]%'),

	CONSTRAINT chk_apellidos CHECK (
        (ApellidoPaterno IS NOT NULL OR ApellidoMaterno IS NOT NULL)
    ),
	Calle VARCHAR(50) NOT NULL CHECK(Calle <> ''),
	NumInterior INT NOT NULL,
	NumExterior INT NOT NULL,
	Colonia VARCHAR(50) NOT NULL CHECK(Colonia <> ''),
	Estado VARCHAR(50) NOT NULL CHECK(Estado <> '' AND Estado LIKE '%[a-zA-Z]%'),
	FechaInicioContrato DATE NOT NULL,
	FechaFinContrato DATE NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Genero VARCHAR(10) NOT NULL CHECK(Genero <> '' AND Genero LIKE '%[a-zA-Z]%'),
	DiasTrabajo INT NOT NULL CHECK(DiasTrabajo > 0),
	HorarioLaboral VARCHAR(50) NOT NULL CHECK(HorarioLaboral <> ''),
	Salario DECIMAL NOT NULL  CHECK(Salario > 0),
	PRIMARY KEY(RFCCuidador),
	FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma)
	
);

CREATE TABLE Alimento(
	IDInsumoAlimento INT,
	Nombre VARCHAR(50) NOT NULL CHECK (Nombre <> '' AND Nombre LIKE '%[a-zA-Z]%'),
	Cantidad INT NOT NULL CHECK(Cantidad > 0),
	FechaCaducidad DATE NOT NULL CHECK(FechaCaducidad < CURRENT_DATE),
	Refrigeracion BOOL NOT NULL,
	TipoAlimento VARCHAR(50) NOT NULL CHECK(TipoAlimento <> ''),
	PRIMARY KEY(IDInsumoAlimento)
		
);

CREATE TABLE Trabajar(
	RFCVeterinario VARCHAR(13) NOT NULL CHECK 
										(RFCVeterinario <> '', AND 
										 (LENGTH(RFCVeterinario = 13) OR 
										  LENGTH(RFCVeterinario = 12) ) AND 
										LEFT(RFCVeterinario,4) LIKE '%[A-Z]%' AND
										RIGHT(RFCVeterinario,6) ~ '^[0-9 ]*$'),
	IDBioma INT NOT NULL,
	FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario(RFCVeterinario),
	FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma)
);
--------------- FINAL PARTE ETHAN ---------------------------------