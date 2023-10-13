/*
 Script para la creación de la base de datos de El Zoologico de Huitziltepec
 */
DROP SCHEMA IF EXISTS public CASCADE;

CREATE SCHEMA public;

CREATE TABLE Servicio(
	IDServicio SERIAL,
	TipoServicio VARCHAR(20) NOT NULL CHECK(TipoServicio IN ('baño', 'tienda', 'comida')),
	PRIMARY KEY (IDServicio)
);

CREATE TABLE TelefonoVisitante(
	IDVisitante SERIAL,
	Telefono CHAR(10) NOT NULL CHECK(Telefono SIMILAR TO '[0-9]+'),
	PRIMARY KEY(IDVisitante, Telefono)
);

CREATE TABLE TelefonoProveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK (
		RFCProveedor <> '',
		AND (
			LENGTH(RFCProveedor = 13)
			OR LENGTH(RFCProveedor = 12)
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Telefono CHAR(10) NOT NULL CHECK(Telefono SIMILAR TO '[0-9]+'),
	PRIMARY KEY(RFCProveedor, Telefono)
);

CREATE TABLE CorreoProveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK (
		RFCProveedor <> '',
		AND (
			LENGTH(RFCProveedor = 13)
			OR LENGTH(RFCProveedor = 12)
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Correo VARCHAR(50) NOT NULL CHECK(Correo LIKE '%_@_%._%'),
	PRIMARY KEY(RFCProveedor, Correo)
);

CREATE TABLE ProveerMedicina(
	IDInsumoMedicina SERIAL,
	RFCProveedor VARCHAR(13) NOT NULL CHECK (
		RFCProveedor <> '',
		AND (
			LENGTH(RFCProveedor = 13)
			OR LENGTH(RFCProveedor = 12)
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	) --TODO FK KEYS
);

--------TABLAS CON LLAVES PRIMARIAS-----------------
CREATE TABLE CorreoVeterinario(
	RFCVeterinario VARCHAR(13) NOT NULL CHECK (
		RFCProveedor <> '',
		AND (
			LENGTH(RFCProveedor = 13)
			OR LENGTH(RFCProveedor = 12)
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Correo VARCHAR(50) CHECK (
		Correo LIKE '%_@_%._%'
		AND Correo <> ''
	),
	PRIMARY KEY(RFCVeterinario, Correo)
);

CREATE TABLE TelefonoVeterinario(
	RFCVeterinario VARCHAR(13) NOT NULL CHECK (
		RFCProveedor <> '',
		AND (
			LENGTH(RFCProveedor = 13)
			OR LENGTH(RFCProveedor = 12)
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Telefono CHAR(10) CHECK(
		Telefono ~ '^[0-9 ]*$'
		AND Telefono <> ''
	),
	PRIMARY KEY(RFCVeterinario, Telefono)
);

------------------------------PARTE ETHAN -----------------------------------------------
CREATE TABLE Notificar(
	idEvento SERIAL,
	IDVisitante SERIAL,
	TipoNotificacion VARCHAR(50) NOT NULL CHECK (TipoNotificacion <> '') FOREIGN KEY (idEvento) REFERENCES Evento(idEvento),
	FOREIGN KEY (IDVisitante) REFERENCES Visitante(IDVisitante)
);

CREATE TABLE Veterinario(
	RFCVeterinario VARCHAR(13) NOT NULL CHECK (
		RFCVeterinario <> '',
		AND (
			LENGTH(RFCVeterinario = 13)
			OR LENGTH(RFCVeterinario = 12)
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Nombre VARCHAR(50) NOT NULL CHECK(
		Nombre <> ''
		AND Nombre LIKE '%[a-zA-Z]%' \
	),
	ApellidoPaterno VARCHAR(50) NOT NULL CHECK(
		ApellidoPaterno <> ''
		AND ApellidoPaterno LIKE '%[a-zA-Z]%'
	),
	ApellidoMaterno VARCHAR(50) NOT NULL CHECK(
		ApellidoMaterno <> ''
		AND ApellidoMaterno LIKE '%[a-zA-Z]%'
	),
	Calle VARCHAR(50) NOT NULL CHECK(Calle <> ''),
	NumInterior INT NOT NULL,
	NumExterior INT NOT NULL,
	Colonia VARCHAR(50) NOT NULL CHECK(Colonia <> ''),
	Estado VARCHAR(50) NOT NULL CHECK(
		Estado <> ''
		AND Estado LIKE '%[a-zA-Z]%'
	),
	FechaInicioContrato DATE NOT NULL,
	FechaFinContrato DATE NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Genero VARCHAR(10) NOT NULL CHECK(
		Genero <> ''
		AND Genero LIKE '%[a-zA-Z]%'
	),
	Salario DECIMAL NOT NULL CHECK(Salario > 0),
	Especialidad VARCHAR(50) NOT NULL CHECK(
		Especialidad <> ''
		AND Especialidad LIKE '%[a-zA-Z]%'
	) PRIMARY KEY(RFCVeterinario)
);

CREATE TABLE Proveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK (
		RFCProveedor <> '',
		AND (
			LENGTH(RFCProveedor = 13)
			OR LENGTH(RFCProveedor = 12)
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Nombre VARCHAR(50) NOT NULL CHECK(
		Nombre <> ''
		AND Nombre LIKE '%[a-zA-Z]%'
	),
	ApellidoPaterno VARCHAR(50) NOT NULL CHECK(
		ApellidoPaterno <> ''
		AND ApellidoPaterno LIKE '%[a-zA-Z]%'
	),
	ApellidoMaterno VARCHAR(50) NOT NULL CHECK(
		ApellidoMaterno <> ''
		AND ApellidoMaterno LIKE '%[a-zA-Z]%'
	),
	Calle VARCHAR(50) NOT NULL CHECK(Calle <> ''),
	NumInterior INT NOT NULL,
	NumExterior INT NOT NULL,
	Colonia VARCHAR(50) NOT NULL CHECK(Colonia <> ''),
	Estado VARCHAR(50) NOT NULL CHECK(
		Estado <> ''
		AND Estado LIKE '%[a-zA-Z]%'
	),
	FechaInicioContrato DATE NOT NULL,
	FechaFinContrato DATE NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Genero VARCHAR(10) NOT NULL CHECK(
		Genero <> ''
		AND Genero LIKE '%[a-zA-Z]%'
	),
	FrecuenciaServicio INT NOT NULL CHECK(FrecuenciaServicio > 0),
	CostoServicio INT NOT NULL CHECK(CostoServicio > 0),
	PRIMARY KEY(RFCProveedor)
);

CREATE TABLE Cuidador(
	RFCCuidador VARCHAR(13) NOT NULL CHECK (
		RFCCuidador <> '',
		AND (
			LENGTH(RFCCuidador = 13)
			OR LENGTH(RFCCuidador = 12)
		)
		AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	IDBioma SERIAL,
	Nombre VARCHAR(50) NOT NULL CHECK(
		Nombre <> ''
		AND Nombre LIKE '%[a-zA-Z]%'
	),
	ApellidoPaterno VARCHAR(50) CHECK(
		ApellidoPaterno <> ''
		AND ApellidoPaterno LIKE '%[a-zA-Z]%'
	),
	ApellidoMaterno VARCHAR(50) CHECK(
		ApellidoMaterno <> ''
		AND ApellidoMaterno LIKE '%[a-zA-Z]%'
	),
	CONSTRAINT chk_apellidos CHECK (
		(
			ApellidoPaterno IS NOT NULL
			OR ApellidoMaterno IS NOT NULL
		)
	),
	Calle VARCHAR(50) NOT NULL CHECK(Calle <> ''),
	NumInterior INT,
	NumExterior INT NOT NULL,
	Colonia VARCHAR(50) NOT NULL CHECK(Colonia <> ''),
	Estado VARCHAR(50) NOT NULL CHECK(
		Estado <> ''
		AND Estado LIKE '%[a-zA-Z]%'
	),
	FechaInicioContrato DATE NOT NULL,
	FechaFinContrato DATE NOT NULL,
	FechaNacimiento DATE NOT NULL,
	Genero VARCHAR(10) NOT NULL CHECK(
		Genero <> ''
		AND Genero LIKE '%[a-zA-Z]%'
	),
	DiasTrabajo INT NOT NULL CHECK(
		DiasTrabajo > 0
		AND DiasTrabajo < 30
	),
	HorarioLaboral VARCHAR(50) NOT NULL CHECK(HorarioLaboral <> ''),
	Salario DECIMAL NOT NULL CHECK(Salario > 0),
	PRIMARY KEY(RFCCuidador),
	FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma)
);

CREATE TABLE Alimento(
	IDInsumoAlimento SERIAL,
	Nombre VARCHAR(50) NOT NULL CHECK (
		Nombre <> ''
		AND Nombre LIKE '%[a-zA-Z]%'
	),
	Cantidad INT NOT NULL CHECK(Cantidad > 0),
	FechaCaducidad DATE NOT NULL CHECK(
		FechaCaducidad < CURRENT_DATE
		AND FechaCaducidad >= CURRENT_DATE
	),
	Refrigeracion BOOL NOT NULL,
	TipoAlimento VARCHAR(50) NOT NULL CHECK(TipoAlimento <> ''),
	PRIMARY KEY(IDInsumoAlimento)
);

CREATE TABLE Trabajar(
	RFCVeterinario VARCHAR(13) NOT NULL CHECK (
		RFCVeterinario <> '',
		AND (
			LENGTH(RFCVeterinario = 13)
			OR LENGTH(RFCVeterinario = 12)
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
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
	PRIMARY KEY(IDInsumoMedicina) FOREIGN KEY (IDInsumoMedicina) REFERENCES Medicina (IDInsumoMedicina),
	FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma)
);

CREATE TABLE Cuidar (
	RFCCuidador VARCHAR(13) NOT NULL CHECK (
		RFCCuidador <> ''
		AND (
			LENGTH(RFCCuidador) = 13
			OR LENGTH(RFCCuidador) = 12
		)
		AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	IDAnimal INT NOT NULL,
	Nombre VARCHAR(50) NOT NULL CHECK (
		Nombre <> ''
		and Nombre like '%[a-zA-z]'
	),
	ApellidoPaterno VARCHAR(50) CHECK (
		ApellidoPaterno <> ''
		and ApellidoPaterno like '%[a-zA-z]'
	),
	ApellidoMaterno VARCHAR(50) CHECK (
		ApellidoPaterno <> ''
		and ApellidoPaterno like '%[a-zA-z]'
	),
	-- Restricción CHECK que permite ambos apellidos o uno de ellos
	CONSTRAINT chk_apellidos CHECK (
		(
			ApellidoPaterno IS NOT NULL
			OR ApellidoMaterno IS NOT NULL
		)
	),
	Calle VARCHAR(50) NOT NULL CHECK (
		Calle <> ''
		AND Calle LIKE '%[a-zA-z]'
	),
	NumInterior INT CHECK(NumInterior > 0),
	NumExterior INT NOT NULL,
	Colonia VARCHAR(50) NOT NULL CHECK (
		Colonia <> ''
		AND Colonia LIKE '%[a-zA-z]'
	),
	Estado VARCHAR(50) NOT NULL CHECK (
		Estado <> ''
		AND Estado LIKE '%[a-zA-z]'
	),
	FechaInicioContrato DATE NOT NULL,
	FechaFinContrato DATE,
	DiasTrabajo INT NOT NULL CHECK(
		DiasTrabajo > 0
		AND DiasTrabajo < 30
	),
	HorarioLaboral TIME NOT NULL,
	Salario DECIMAL NOT NULL (Salario > 0),
	Genero VARCHAR(10) NOT NULL CHECK (
		Genero <> ''
		AND Genero LIKE '%[a-zA-z]'
	),
	Sexo VARCHAR(10) NOT NULL CHECK (
		Sexo <> ''
		AND Sexo LIKE '%[a-zA-z]'
	),
	Altura DECIMAL NOT NULL,
	Peso DECIMAL NOT NULL,
	Especie VARCHAR(50) NOT NULL CHECK (
		Especie <> ''
		AND Especie LIKE '%[a-zA-z]'
	),
	NombreAnimal VARCHAR(50) NOT NULL CHECK (
		NombreAnimal <> ''
		AND NombreAnimal LIKE '%[a-zA-z]'
	),
	Alimentacion VARCHAR(50) NOT NULL CHECK (
		Alimentacion <> ''
		AND Alimentacion LIKE '%[a-zA-z]'
	),
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
	RFCCuidador VARCHAR(13) NOT NULL CHECK (
		RFCCuidador <> '',
		AND (
			LENGTH(RFCCuidador = 13)
			OR LENGTH(RFCCuidador = 12)
		)
		AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Correo VARCHAR(50) CHECK(
		Correo LIKE '%@%._%'
		AND Correo <> ''
	),
	PRIMARY KEY(RFCCuidador, Correo)
);

--TelefonoCuidador--
CREATE TABLE TelefonoCuidador(
	RFCCuidador VARCHAR(13) NOT NULL CHECK (
		RFCCuidador <> '',
		AND (
			LENGTH(RFCCuidador = 13)
			OR LENGTH(RFCCuidador = 12)
		)
		AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Telefono CHAR(10) CHECK(
		Telefono ~ '^[0-9 ] *$'
		AND Telefono <> ''
	),
	PRIMARY KEY(RFCCuidador, Telefono)
);

--CorreoVisitante--
CREATE TABLE correovisitante (
	IDVisitante SERIAL,
	Correo VARCHAR(50) CHECK(
		Correo LIKE '%@%._%'
		AND Correo <> ''
	),
	PRIMARY KEY(IdVisitante, Correo)
);

-- TABLAS CON FK
--Jaula--
CREATE TABLE Jaula(
	IDJaula SERIAL,
	IDAnimal INT NOT NULL,
	PRIMARY KEY(IDJaula),
	CONSTRAINT fk_animal FOREIGN KEY (IDAnimal) REFERENCES Animal (IDAnimal)
);

--Evento--
CREATE TABLE Evento(
	IDEvento SERIAL,
	IDVisitante INT NOT NULL,
	TipoEvento VARCHAR(50) NOT NULL CHECK(TipoEvento <> ''),
	Fecha DATE NOT NULL,
	Capacidad INT NOT NULL CHECK(Capacidad > 0),
	PRIMARY KEY(IDEvento),
	CONSTRAINT fk_visitante FOREIGN KEY (IDVisitante) REFERENCES Visitante (IDVisitante)
) --Tener--
CREATE TABLE Tener(
	IDBioma SERIAL,
	IDServicio SERIAL,
	CONSTRAINT fk_idbioma FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma),
	CONSTRAINT fk_idservicio FOREIGN KEY (IDServicio) REFERENCES Servicio (IDServicio)
) --------------- FIN PARTE ROGER ---------------
--------------- ?Inicio PARTE Luffy ---------------
-- Bioma
CREATE TABLE Bioma(
	IDBioma SERIAL,
	TipoBioma VARCHAR(50) NOT NULL CHECK (
		TipoBioma IN (
			'desierto',
			'pastizales',
			'franja costera',
			'aviario',
			'bosque templado',
			'bosque tropical'
		)
	),
	PRIMARY KEY(IDBioma)
);

-- Visitante
CREATE TABLE Visitante(
	IDVisitante SERIAL,
	Genero VARCHAR(50) NOT NULL CHECK (
		Genero <> ''
		AND Genero LIKE '%[a-zA-Z]%'
	),
	Nombre VARCHAR(50) NOT NULL CHECK (
		Nombre <> ''
		AND Nombre LIKE '%[a-zA-Z]%'
	),
	Paterno VARCHAR(50) NOT NULL CHECK (
		Paterno <> ''
		AND Paterno LIKE '%[a-zA-Z]%'
	),
	Materno VARCHAR(50) NOT NULL CHECK (
		Materno <> ''
		AND Materno LIKE '%[a-zA-Z]%'
	),
	PRIMARY KEY(IDVisitante)
);

-- Ticket
CREATE TABLE Ticket(
	NumTicket SERIAL,
	IDVisitante SERIAL,
	Descuento INT NOT NULL CHECK (
		Descuento >= 0
		AND Descuento <= 100
	),
	CostoUnitario DECIMAL NOT NULL CHECK (CostoUnitario > 0),
	TipoServicio VARCHAR(50) NOT NULL CHECK (
		TipoServicio IN ('baño', 'tienda', 'comida')
	),
	Fecha DATE NOT NULL,
	PRIMARY KEY(NumTicket),
	CONSTRAINT fk_idvisitante FOREIGN KEY (IDVisitante) REFERENCES Visitante (IDVisitante)
);

-- Animal
CREATE TABLE Animal(
	IDAnimal SERIAL,
	IDBioma SERIAL,
	IDJaula SERIAL,
	NombreAnimal VARCHAR(50) NOT NULL CHECK (
		NombreAnimal <> ''
		AND NombreAnimal LIKE '%[a-zA-Z]%'
	),
	Sexo VARCHAR(50) NOT NULL CHECK (Sexo IN ('macho', 'hembra')),
	Altura DECIMAL NOT NULL CHECK (Altura > 0),
	Peso DECIMAL NOT NULL CHECK (Peso > 0),
	Especie VARCHAR(50) NOT NULL CHECK (
		Especie <> ''
		AND Especie LIKE '%[a-zA-Z]%'
	),
	Edad INT NOT NULL CHECK (Edad > 0),
	Alimentacion VARCHAR(50) NOT NULL CHECK (
		Alimentacion IN (
			'carnívoro',
			'herbívoro',
			'omnívoro'
		)
	),
	PRIMARY KEY(IDAnimal),
	CONSTRAINT fk_idbioma FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma) CONSTRAINT fk_idjaula FOREIGN KEY (IDJaula) REFERENCES Jaula (IDJaula)
);

-- Atender
CREATE TABLE Atender(
	IDAnimal SERIAL,
	IndicacionesMedicas Text NOT NULL CHECK (
		IndicacionesMedicas <> ''
		AND IndicacionesMedicas LIKE '%[a-zA-Z]%'
	),
	RFCVeterinario VARCHAR(13) NOT NULL CHECK (
		RFCVeterinario <> '',
		AND (
			LENGTH(RFCVeterinario = 13)
			OR LENGTH(RFCVeterinario = 12)
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	CONSTRAINT fk_idanimal FOREIGN KEY (IDAnimal) REFERENCES Animal (IDAnimal) CONSTRAINT fk_rfcveterinario FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario (RFCVeterinario)
);

--------------- ?Fin PARTE Luffy ---------------