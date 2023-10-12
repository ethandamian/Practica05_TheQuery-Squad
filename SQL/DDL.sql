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
	IDInsumoAlimento INT,
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
	IDBioma INT NOT NULL,
	FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario(RFCVeterinario),
	FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma)
);

--------------- FINAL PARTE ETHAN ---------------------------------

------------------------------------Parte Gael------------------------------------

CREATE TABLE DistribuirMedicina(
	IDInsumoMedicina int,
	IDBioma int,
	 constraint fk_Medicina 
    	foreign key (IDInsumoMedicina) 
    		references Medicina (IDInsumoMedicina),
    constraint fk_Bioma
    	foreign key (IDBioma) 
    		references Bioma (IDBioma)

);

create table Medicina(
	IDInsumoMedicina int,
	Nombre varchar(50) not null check(Nombre <> ''),
	Cantidad int,
	FechaCaducidad date,
	Refrigeracion bool, 
	Lote int not NULL,
	Laboratorio varchar(50) not null check(Laboratorio <> ''),
	primary key(IDInsumoMedicina)

); 

CREATE TABLE Cuidar (
    RFCCuidador varchar(13) NOT NULL CHECK (RFCCuidador <> '' AND (LENGTH(RFCCuidador) = 13 OR LENGTH(RFCCuidador) = 12)),
    IDAnimal int not null,
    Nombre varchar(50) NOT NULL CHECK (Nombre <> '' and Nombre like '%[a-zA-z]'),
    ApellidoPaterno varchar(50) check (ApellidoPaterno <> '' and ApellidoPaterno like '%[a-zA-z]'),
    ApellidoMaterno varchar(50) check (ApellidoPaterno <> '' and ApellidoPaterno like '%[a-zA-z]'),
    -- Restricción CHECK que permite ambos apellidos o uno de ellos
    CONSTRAINT chk_apellidos CHECK (
        (ApellidoPaterno IS NOT NULL OR ApellidoMaterno IS NOT NULL)
    ),
    Calle varchar(50) NOT NULL CHECK (Calle <> '' and Calle like '%[a-zA-z]'),
    NumInterior int,
    NumExterior int not null,
    Colonia varchar(50) NOT NULL CHECK (Colonia <> '' and Colonia like '%[a-zA-z]'),
    Estado varchar(50) NOT NULL CHECK (Estado <> '' and Estado like '%[a-zA-z]'),
    FechaInicioContrato date not NULL,
    FechaFinContrato date not NULL,
    DiasTrabajo int not null check (DiasTrabajo > 0 and DiasTrabajo < 30),
    HorarioLaboral time not null,
    Salario decimal not null check (Salario > 0),
    Genero varchar(10) not null check (Genero <> ''),
    Sexo varchar(10) not null check (Sexo <> '' and Sexo like '%[a-zA-z]'),
    Altura decimal not null,
    Peso decimal not null,
    Especie varchar(50) not null check (Especie <> '' and Especie like '%[a-zA-z]'),
    NombreAnimal varchar(50) not null check (NombreAnimal <> '' and NombreAnimal like '%[a-zA-z]'),
    Alimentacion varchar(50) not null check (Alimentacion <> '' and Alimentacion like '%[a-zA-z]'),
    constraint fk_cuidador 
    	foreign key (RFCCuidador) 
    		references Cuidador (RFCCuidador),
    constraint fk_animal 
    	foreign key (IDAnimal) 
    		references Animal (IDAnimal)
);

CREATE TABLE Comprar(
	IDVisitante int,
	IDServicio int,
	 constraint fk_Visitante 
    	foreign key (IDVisitante) 
    		references Visitante (IDVisitante),
    constraint fk_Servicio
    	foreign key (IDServicio) 
    		references Servicio (IDServicio)
    		

);

create  table ProveerAlimento(
	IDInsumoAlimento int,
	RFCProveedor varchar(13),
	 constraint fk_Alimento 
    	foreign key (IDInsumoAlimento) 
    		references Alimento (IDInsumoAlimento),
    constraint fk_Proveedor
    	foreign key (RFCProveedor) 
    		references Proveedor(RFCProveedor)

);

create table DistribuirAlimento(
	IDInsumoAlimento int,
	IDBioma int,
	 constraint fk_Alimento
    	foreign key (IDInsumoAlimento) 
    		references Alimento (IDInsumoAlimento),
    constraint fk_Bioma
    	foreign key (IDBioma) 
    		references Bioma(IDBioma)

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
	IDVisitante serial NOT NULL CHECK (IDVisitante > 0),
	Correo VARCHAR(50) CHECK(Correo LIKE '%@%._%' AND Correo <> ''),
	PRIMARY KEY(IdVisitante, Correo)
);

-- TABLAS CON FK

--Jaula--
CREATE TABLE Jaula(
	IDJaula serial NOT NULL CHECK(IDJaula > 0),
	IDAnimal INT NOT NULL,
	PRIMARY KEY(IDJaula),
	CONSTRAINT fk_animal 
    	FOREIGN KEY (IDAnimal) 
    		REFERENCES Animal (IDAnimal)
);

--Evento--
CREATE TABLE  Evento(
	IDEvento serial NOT NULL CHECK(IDEvento > 0),
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
