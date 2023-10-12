/*
Script para la creación de la base de datos de El Zoologico de Huitziltepec
*/

DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

CREATE TABLE Servicio(
	IDServicio SERIAL,
	TipoServicio VARCHAR(20) NOT NULL CHECK(TipoServicio IN ('baño','tienda','comida')),
	PRIMARY KEY (IDServicio)
);

CREATE TABLE TelefonoVisitante(
	IDVisitante SERIAL,
	Telefono CHAR(10) NOT NULL CHECK(Telefono SIMILAR TO '[0-9]+'),
	PRIMARY KEY(IDVisitante, Telefono)
);

CREATE TABLE TelefonoProveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK 
										(RFCProveedor <> '', AND 
										 (LENGTH(RFCProveedor = 13) OR 
										  LENGTH(RFCProveedor = 12) ) AND 
										LEFT(RFCProveedor,4) LIKE '%[A-Z]%' AND
										RIGHT(RFCProveedor,6) ~ '^[0-9 ]*$'),
	Telefono CHAR(10) NOT NULL CHECK(Telefono SIMILAR TO '[0-9]+'),
	PRIMARY KEY(RFCProveedor, Telefono)
);

CREATE TABLE CorreoProveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK 
										(RFCProveedor <> '', AND 
										 (LENGTH(RFCProveedor = 13) OR 
										  LENGTH(RFCProveedor = 12) ) AND 
										LEFT(RFCProveedor,4) LIKE '%[A-Z]%' AND
										RIGHT(RFCProveedor,6) ~ '^[0-9 ]*$'),
	Correo VARCHAR(50) NOT NULL CHECK(Correo LIKE '%_@_%._%' ),
	PRIMARY KEY(RFCProveedor, Correo)
);

CREATE TABLE ProveerMedicina(
	IDInsumoMedicina SERIAL,
	RFCProveedor VARCHAR(13) NOT NULL CHECK 
										(RFCProveedor <> '', AND 
										 (LENGTH(RFCProveedor = 13) OR 
										  LENGTH(RFCProveedor = 12) ) AND 
										LEFT(RFCProveedor,4) LIKE '%[A-Z]%' AND
										RIGHT(RFCProveedor,6) ~ '^[0-9 ]*$')
	--TODO FK KEYS
);

--------TABLAS CON LLAVES PRIMARIAS-----------------
CREATE TABLE CorreoVeterinario(
	RFCVeterinario VARCHAR(13) NOT NULL CHECK 
										(RFCProveedor <> '', AND 
										 (LENGTH(RFCProveedor = 13) OR 
										  LENGTH(RFCProveedor = 12) ) AND 
										LEFT(RFCProveedor,4) LIKE '%[A-Z]%' AND
										RIGHT(RFCProveedor,6) ~ '^[0-9 ]*$'),
	Correo VARCHAR(50)  CHECK (Correo LIKE '%_@_%._%' AND Correo <> ''),
	PRIMARY KEY(RFCVeterinario,Correo)
);

CREATE TABLE TelefonoVeterinario(
	RFCVeterinario VARCHAR(13) NOT NULL CHECK 
										(RFCProveedor <> '', AND 
										 (LENGTH(RFCProveedor = 13) OR 
										  LENGTH(RFCProveedor = 12) ) AND 
										LEFT(RFCProveedor,4) LIKE '%[A-Z]%' AND
										RIGHT(RFCProveedor,6) ~ '^[0-9 ]*$'),
	Telefono CHAR(10) CHECK(Telefono ~ '^[0-9 ]*$' AND Telefono <> ''),
	PRIMARY KEY(RFCVeterinario,Telefono)

);

------------------------------PARTE ETHAN -----------------------------------------------
CREATE TABLE Notificar(
	idEvento SERIAL,
	IDVisitante SERIAL,
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
	IDBioma SERIAL, 
	Nombre VARCHAR(50) NOT NULL CHECK(Nombre <> '' AND Nombre LIKE '%[a-zA-Z]%'),
	ApellidoPaterno VARCHAR(50) CHECK(ApellidoPaterno <> '' AND ApellidoPaterno LIKE '%[a-zA-Z]%'),
	ApellidoMaterno VARCHAR(50) CHECK(ApellidoMaterno <> '' AND ApellidoMaterno LIKE '%[a-zA-Z]%'),

	CONSTRAINT chk_apellidos CHECK (
        (ApellidoPaterno IS NOT NULL OR ApellidoMaterno IS NOT NULL)
    ),
	Calle VARCHAR(50) NOT NULL CHECK(Calle <> ''),
	NumInterior INT,
	NumExterior INT NOT NULL,
	Colonia VARCHAR(50) NOT NULL CHECK(Colonia <> ''),
	Estado VARCHAR(50) NOT NULL CHECK(Estado <> '' AND Estado LIKE '%[a-zA-Z]%'),
	FechaInicioContrato DATE NOT NULL,
	FechaFinContrato DATE NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Genero VARCHAR(10) NOT NULL CHECK(Genero <> '' AND Genero LIKE '%[a-zA-Z]%'),
	DiasTrabajo INT NOT NULL CHECK(DiasTrabajo > 0 AND DiasTrabajo <30),
	HorarioLaboral VARCHAR(50) NOT NULL CHECK(HorarioLaboral <> ''),
	Salario DECIMAL NOT NULL  CHECK(Salario > 0),
	PRIMARY KEY(RFCCuidador),
	FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma)
	
);

CREATE TABLE Alimento(
	IDInsumoAlimento SERIAL,
	Nombre VARCHAR(50) NOT NULL CHECK (Nombre <> '' AND Nombre LIKE '%[a-zA-Z]%'),
	Cantidad INT NOT NULL CHECK(Cantidad > 0),
	FechaCaducidad DATE NOT NULL CHECK(FechaCaducidad < CURRENT_DATE AND FechaCaducidad >= CURRENT_DATE),
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
	IDBioma SERIAL,
	FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario(RFCVeterinario),
	FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma)
);

--------------- FINAL PARTE ETHAN ---------------------------------

------------------------------------Parte Gael------------------------------------

CREATE TABLE DistribuirMedicina(
	IDInsumoMedicina SERIAL,
	IDBioma SERIAL,
    	FOREIGN KEY (IDInsumoMedicina) REFERENCES Medicina (IDInsumoMedicina),
    	FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma)

);

CREATE TABLE Medicina(
	IDInsumoMedicina SERIAL,
	Nombre VARCHAR(50) NOT NULL CHECK(Nombre <> ''),
	Cantidad INT NOT NULL,
	FechaCaducidad DATE NOT NULL,
	Refrigeracion BOOL NOT NULL, 
	Lote INT NOT NULL,
	Laboratorio VARCHAR(50) NOT NULL CHECK(Laboratorio <> ''),
	PRIMARY KEY(IDInsumoMedicina)
   	FOREIGN KEY (IDInsumoMedicina) REFERENCES Medicina (IDInsumoMedicina),
   	FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma)

);


CREATE TABLE Cuidar (
    RFCCuidador VARCHAR(13) NOT NULL CHECK (RFCCuidador <> '' AND (LENGTH(RFCCuidador) = 13 OR LENGTH(RFCCuidador) = 12)),
    IDAnimal INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL CHECK (Nombre <> '' and Nombre like '%[a-zA-z]'),
    ApellidoPaterno VARCHAR(50) CHECK (ApellidoPaterno <> '' and ApellidoPaterno like '%[a-zA-z]'),
    ApellidoMaterno VARCHAR(50) CHECK (ApellidoPaterno <> '' and ApellidoPaterno like '%[a-zA-z]'),
    -- Restricción CHECK que permite ambos apellidos o uno de ellos
    CONSTRAINT chk_apellidos CHECK (
        (ApellidoPaterno IS NOT NULL OR ApellidoMaterno IS NOT NULL)
    ),
    Calle VARCHAR(50) NOT NULL CHECK (Calle <> '' AND Calle LIKE '%[a-zA-z]'),
    NumInterior INT CHECK(NumInterior>0),
    NumExterior INT NOT NULL,
    Colonia VARCHAR(50) NOT NULL CHECK (Colonia <> '' AND Colonia LIKE '%[a-zA-z]'),
    Estado VARCHAR(50) NOT NULL CHECK (Estado <> '' AND Estado LIKE '%[a-zA-z]'),
    FechaInicioContrato DATE NOT NULL,
    FechaFinContrato DATE,
    DiasTrabajo INT NOT NULL CHECK(DiasTrabajo > 0 AND DiasTrabajo < 30),
    HorarioLaboral TIME NOT NULL,
    Salario DECIMAL NOT NULL (Salario > 0),
    Genero VARCHAR(10) NOT NULL CHECK (Genero <> '' AND Genero LIKE '%[a-zA-z]'),
    Sexo VARCHAR(10) NOT NULL CHECK (Sexo <> '' AND Sexo LIKE '%[a-zA-z]'),
    Altura DECIMAL NOT NULL,
    Peso DECIMAL NOT NULL,
    Especie VARCHAR(50) NOT NULL CHECK (Especie <> '' AND Especie LIKE '%[a-zA-z]'),
    NombreAnimal VARCHAR(50) NOT NULL CHECK (NombreAnimal <> '' AND NombreAnimal LIKE '%[a-zA-z]'),
    Alimentacion VARCHAR(50) NOT NULL CHECK (Alimentacion <> '' AND Alimentacion LIKE '%[a-zA-z]'),
    FOREIGN KEY (RFCCuidador) REFERENCES Cuidador (RFCCuidador),
   	FOREIGN KEY (IDAnimal) REFERENCES Animal (IDAnimal)
);

CREATE TABLE Comprar(
	IDVisitante SERIAL,
	IDServicio SERIAL,
    FOREIGN KEY (IDVisitante) REFERENCES Visitante (IDVisitante),
    FOREIGN KEY (IDServicio) REFERENCES Servicio (IDServicio)
);

CREATE TABLE ProveerAlimento(
	IDInsumoAlimento SERIAL,
	RFCProveedor VARCHAR(13),
    FOREIGN KEY (IDInsumoAlimento) REFERENCES Alimento (IDInsumoAlimento),
    FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor)

);


CREATE TABLE DistribuirAlimento(
	IDInsumoAlimento SERIAL,
	IDBioma SERIAL,
    FOREIGN KEY (IDInsumoAlimento) REFERENCES Alimento (IDInsumoAlimento),
    FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma)

);

------------------------------------Parte Gael Fin------------------------------------

--------------- INICIA PARTE ROGER ---------------

--CorreoCuidador--
CREATE TABLE CorreoCuidador(
	RFCCuidador VARCHAR(13) CHECK(LENGTH(RFCCuidador) = 13 OR LENGTH(RFCCuidador) = 12 AND RFCCuidador <> ''),
	Correo VARCHAR(50) CHECK(Correo LIKE '%@%._%' AND Correo <> ''),
	PRIMARY KEY(RFCCuidador, Correo)
);

--TelefonoCuidador--
CREATE TABLE TelefonoCuidador(
	RFCCuidador VARCHAR(13) CHECK(LENGTH(RFCCuidador) = 13 OR LENGTH(RFCCuidador) = 12 AND RFCCuidador <> ''),
	Telefono CHAR(10) CHECK(Telefono ~ '^[0-9 ] *$' AND Telefono <> ''),
	PRIMARY KEY(RFCCuidador,Telefono)
);

--CorreoVisitante--
CREATE TABLE correovisitante (
	IDVisitante SERIAL,
	Correo VARCHAR(50) CHECK(Correo LIKE '%@%._%' AND Correo <> ''),
	PRIMARY KEY(IdVisitante, Correo)
);

-- TABLAS CON FK

--Jaula--
CREATE TABLE Jaula(
	IDJaula SERIAL,
	IDAnimal INT NOT NULL,
	PRIMARY KEY(IDJaula),
	CONSTRAINT fk_animal 
    	FOREIGN KEY (IDAnimal) 
    		REFERENCES Animal (IDAnimal)
);

--Evento--
CREATE TABLE  Evento(
	IDEvento SERIAL,
	IDVisitante INT NOT NULL, 
	TipoEvento VARCHAR(50) NOT NULL,
	Fecha DATE NOT NULL CHECK (fechaColumn >= GETDATE()),
	Capacidad INT NOT NULL,
	PRIMARY KEY(IDEvento),
	CONSTRAINT fk_visitante
		FOREIGN KEY (IDVisitante)
			REFERENCES Visitante (IDVisitante)
)
--Tener--
CREATE TABLE Tener(
	IDBioma INT NOT NULL,
	IDServicio INT NOT NULL
	CONSTRAINT fk_idbioma
		FOREIGN KEY (IDBioma)
			REFERENCES Bioma (IDBioma),
	CONSTRAINT fk_idservicio
		FOREIGN KEY (IDServicio)
			REFERENCES Servicio (IDServicio)
	
)

--------------- FIN PARTE ROGER ---------------
