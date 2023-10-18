/*
 Script para la creación de la base de datos de El Zoologico de Huitziltepec
 */
DROP SCHEMA IF EXISTS public CASCADE;

CREATE SCHEMA public;


------------------------------------- Tablas con llaves primarias ----------------------------------

CREATE TABLE Servicio(
	IDServicio SERIAL,
	TipoServicio VARCHAR(20)
);


-- RESTRICCIONES DE DOMINIO Servicio
ALTER TABLE Servicio ADD CONSTRAINT servicio_d1
CHECK(TipoServicio IN ('baño', 'tienda', 'comida'));
ALTER TABLE Servicio ALTER COLUMN TipoServicio SET NOT NULL;

-- LLAVES Servicio 
ALTER TABLE Servicio ADD CONSTRAINT servicio_pk
PRIMARY KEY (IDServicio);


CREATE TABLE Veterinario(
	RFCVeterinario VARCHAR(13),
	Nombre VARCHAR(50),
	ApellidoPaterno VARCHAR(50),
	ApellidoMaterno VARCHAR(50),
	Calle VARCHAR(50),
	NumInterior INT,
	NumExterior INT,
	Colonia VARCHAR(50),
	Estado VARCHAR(50),
	FechaInicioContrato DATE,
	FechaFinContrato DATE,
	FechaNacimiento DATE,
	Genero VARCHAR(10),
	Salario DECIMAL,
	Especialidad VARCHAR(50)
);


-- RESTRICCIONES DE DOMINIO Veterinario

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d1
CHECK ( RFCVeterinario <> '' 
	AND (LENGTH(RFCVeterinario) = 13 OR LENGTH(RFCVeterinario) = 12)
	AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Veterinario ALTER COLUMN RFCVeterinario SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d2
CHECK(Nombre <> ''
	AND Nombre LIKE '%[a-zA-Z]%');
ALTER TABLE Veterinario ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d3
CHECK(ApellidoPaterno <> ''
	AND ApellidoPaterno LIKE '%[a-zA-Z]%');

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d4
CHECK(ApellidoMaterno <> ''
	AND ApellidoMaterno LIKE '%[a-zA-Z]%');

ALTER TABLE Veterinario ADD CONSTRAINT checkApe
CHECK (
		(
			ApellidoPaterno IS NOT NULL
			OR ApellidoMaterno IS NOT NULL
		)
	);

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d5
CHECK(Calle <> '');
ALTER TABLE Veterinario ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Veterinario ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Veterinario ALTER COLUMN NumExterior SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d6
CHECK(Colonia <> '');
ALTER TABLE Veterinario ALTER COLUMN Colonia SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d7
CHECK(Estado <> ''
	AND Estado LIKE '%[a-zA-Z]%');
ALTER TABLE Veterinario ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Veterinario ALTER COLUMN FechaInicioContrato SET NOT NULL;
ALTER TABLE Veterinario ALTER COLUMN FechaFinContrato SET NOT NULL;
ALTER TABLE Veterinario ALTER COLUMN FechaNacimiento SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d8
CHECK(Genero <> ''
	AND Genero LIKE '%[a-zA-Z]%');
ALTER TABLE Veterinario ALTER COLUMN Genero SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d9
CHECK(Salario > 0);
ALTER TABLE Veterinario ALTER COLUMN Salario SET NOT NULL;

ALTER TABLE Veterinario ADD CONSTRAINT veterinario_d10
CHECK(Especialidad <> ''
	AND Especialidad LIKE '%[a-zA-Z]%');
ALTER TABLE Veterinario ALTER COLUMN Especialidad SET NOT NULL;


--LLAVES Veterinario
ALTER TABLE Veterinario ADD CONSTRAINT veterinario_pk
PRIMARY KEY(RFCVeterinario);







CREATE TABLE Proveedor(
	RFCProveedor VARCHAR(13),
	Nombre VARCHAR(50),
	ApellidoPaterno VARCHAR(50),
	ApellidoMaterno VARCHAR(50),
	Calle VARCHAR(50),
	NumInterior INT ,
	NumExterior INT ,
	Colonia VARCHAR(50),
	Estado VARCHAR(50) ,
	FechaInicioContrato DATE,
	FechaFinContrato DATE,
	FechaNacimiento DATE,
	Genero VARCHAR(10),
	FrecuenciaServicio INT,
	CostoServicio INT
);


-- RESTRICCIONES DE DOMINIO Proveedor

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d1
CHECK ( RFCProveedor <> '' 
	AND (LENGTH(RFCProveedor) = 13 OR LENGTH(RFCProveedor) = 12)
	AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Proveedor ALTER COLUMN RFCProveedor SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d2
CHECK(Nombre <> ''
	AND Nombre LIKE '%[a-zA-Z]%');
ALTER TABLE Proveedor ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d3
CHECK(ApellidoPaterno <> ''
	AND ApellidoPaterno LIKE '%[a-zA-Z]%');

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d4
CHECK(ApellidoMaterno <> ''
	AND ApellidoMaterno LIKE '%[a-zA-Z]%');

ALTER TABLE Proveedor ADD CONSTRAINT checkApe
CHECK (
		(
			ApellidoPaterno IS NOT NULL
			OR ApellidoMaterno IS NOT NULL
		)
	);

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d5
CHECK(Calle <> '');
ALTER TABLE Proveedor ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN NumExterior SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d6
CHECK(Colonia <> '');
ALTER TABLE Proveedor ALTER COLUMN Colonia SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d7
CHECK(Estado <> ''
	AND Estado LIKE '%[a-zA-Z]%');
ALTER TABLE Proveedor ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN FechaInicioContrato SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN FechaFinContrato SET NOT NULL;
ALTER TABLE Proveedor ALTER COLUMN FechaNacimiento SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d8
CHECK(Genero <> ''
	AND Genero LIKE '%[a-zA-Z]%');
ALTER TABLE Proveedor ALTER COLUMN Genero SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d9
CHECK(FrecuenciaServicio > 0);
ALTER TABLE Proveedor ALTER COLUMN FrecuenciaServicio SET NOT NULL;

ALTER TABLE Proveedor ADD CONSTRAINT proveedor_d10
CHECK(CostoServicio > 0);
ALTER TABLE Proveedor ALTER COLUMN CostoServicio SET NOT NULL;


--LLAVES Proovedor
ALTER TABLE Proveedor ADD CONSTRAINT proveedor_pk
PRIMARY KEY(RFCProveedor);



CREATE TABLE Bioma(
	IDBioma SERIAL,
	TipoBioma VARCHAR(50),
	CantidadJaulas INT
);


-- RESTRICCIONES DE DOMINIO Bioma
ALTER TABLE Bioma ADD CONSTRAINT bioma_d1
 CHECK (
		TipoBioma IN (
			'desierto',
			'pastizales',
			'franja costera',
			'aviario',
			'bosque templado',
			'bosque tropical'
		)
	);
ALTER TABLE Bioma ALTER COLUMN TipoBioma SET NOT NULL;

ALTER TABLE Bioma ADD CONSTRAINT bioma_d2
CHECK(CantidadJaulas >= 0); 
ALTER TABLE Bioma ALTER COLUMN CantidadJaulas SET NOT NULL;

-- LLAVES Bioma
ALTER TABLE Bioma ADD CONSTRAINT bioma_pk
PRIMARY KEY (IDBioma);


CREATE TABLE Alimento(
	IDInsumoAlimento SERIAL,
	Nombre VARCHAR(50),
	Cantidad INT,
	FechaCaducidad DATE,
	Refrigeracion BOOL,
	TipoAlimento VARCHAR(50)
	
);

-- RESTRICCIONES DE DOMINIO Alimento
ALTER TABLE Alimento ADD CONSTRAINT alimento_d1
CHECK (Nombre <> ''
	AND Nombre LIKE '%[a-zA-Z]%');
ALTER TABLE Alimento ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Alimento ADD CONSTRAINT alimento_d2
CHECK(Cantidad > 0);
ALTER TABLE Alimento ALTER COLUMN Cantidad SET NOT NULL;
ALTER TABLE Alimento ADD CONSTRAINT alimento_d3
CHECK(FechaCaducidad < CURRENT_DATE
	AND FechaCaducidad >= CURRENT_DATE);
ALTER TABLE Alimento ALTER COLUMN FechaCaducidad SET NOT NULL;
ALTER TABLE Alimento ALTER COLUMN Refrigeracion SET NOT NULL;

ALTER TABLE Alimento ADD CONSTRAINT alimento_d4
CHECK(TipoAlimento <> '');
ALTER TABLE Alimento ALTER COLUMN TipoAlimento SET NOT NULL;

--LLAVES Alimento
ALTER TABLE Alimento ADD CONSTRAINT alimento_pk
PRIMARY KEY(IDInsumoAlimento);


CREATE TABLE Visitante(
	IDVisitante SERIAL,
	Genero VARCHAR(50),
	Nombre VARCHAR(50),
	Paterno VARCHAR(50),
	Materno VARCHAR(50)
);

-- RESTRICCIONES DE DOMINIO Visitante
ALTER TABLE Visitante ADD CONSTRAINT visitante_d1
CHECK (Genero <> ''
	AND Genero LIKE '%[a-zA-Z]%');
ALTER TABLE Visitante ALTER COLUMN Genero SET NOT NULL;

ALTER TABLE Visitante ADD CONSTRAINT visitante_d2
CHECK (Nombre <> ''
	   AND Nombre LIKE '%[a-zA-Z]%');
ALTER TABLE Visitante ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Visitante ADD CONSTRAINT visitante_d3
 CHECK (Paterno <> ''
		AND Paterno LIKE '%[a-zA-Z]%');

ALTER TABLE Visitante ADD CONSTRAINT visitante_d4
 CHECK (Materno <> ''
		AND Materno LIKE '%[a-zA-Z]%');

ALTER TABLE Visitante ADD CONSTRAINT checkApe
CHECK (
		(
			Paterno IS NOT NULL
			OR Materno IS NOT NULL
		)
	);

-- LLAVES Visitante
ALTER TABLE Visitante ADD CONSTRAINT visitante_pk
PRIMARY KEY(IDVisitante);



CREATE TABLE Medicina(
	IDInsumoMedicina SERIAL,
	Nombre VARCHAR(50),
	Cantidad INT,
	FechaCaducidad DATE,
	Refrigeracion BOOL,
	Lote INT,
	Laboratorio VARCHAR(50)
);


-- RESTRICCIONES DE DOMINIO Medicina
ALTER TABLE Medicina ADD CONSTRAINT medicina_d1
CHECK(Nombre <> '');
ALTER TABLE Medicina ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Medicina ALTER COLUMN Cantidad SET NOT NULL;

ALTER TABLE Medicina ALTER COLUMN FechaCaducidad SET NOT NULL;

ALTER TABLE Medicina ALTER COLUMN Refrigeracion SET NOT NULL;

ALTER TABLE Medicina ALTER COLUMN Lote SET NOT NULL;

ALTER TABLE Medicina ADD CONSTRAINT medicina_d2
CHECK(Laboratorio <> '');
ALTER TABLE Medicina ALTER COLUMN Laboratorio SET NOT NULL;

-- LLAVES Medicina
ALTER TABLE Medicina ADD CONSTRAINT medicina_pk
PRIMARY KEY(IDInsumoMedicina);


CREATE TABLE Jaula(
	IDJaula SERIAL
);

-- LLAVES Jaula
ALTER TABLE Jaula ADD CONSTRAINT jaula_pk
PRIMARY KEY(IDJaula);

-----------------------------------TABLAS CON LLAVES FORANEAS -------------------------------------

CREATE TABLE Cuidador(
	RFCCuidador VARCHAR(13),
	IDBioma SERIAL,
	Nombre VARCHAR(50),
	ApellidoPaterno VARCHAR(50),
	ApellidoMaterno VARCHAR(50),
	Calle VARCHAR(50),
	NumInterior INT,
	NumExterior INT,
	Colonia VARCHAR(50),
	Estado VARCHAR(50),
	FechaInicioContrato DATE,
	FechaFinContrato DATE,
	FechaNacimiento DATE,
	Genero VARCHAR(10),
	DiasTrabajo INT,
	HorarioLaboral TIME,
	Salario DECIMAL
);




-- RESTRICCIONES DE DOMINIO Cuidador

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d1
CHECK ( RFCCuidador <> '' 
	AND (LENGTH(RFCCuidador) = 13 OR LENGTH(RFCCuidador) = 12)
	AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Cuidador ALTER COLUMN RFCCuidador SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d2
CHECK(Nombre <> ''
	AND Nombre LIKE '%[a-zA-Z]%');
ALTER TABLE Cuidador ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d3
CHECK(ApellidoPaterno <> ''
	AND ApellidoPaterno LIKE '%[a-zA-Z]%');

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d4
CHECK(ApellidoMaterno <> ''
	AND ApellidoMaterno LIKE '%[a-zA-Z]%');

ALTER TABLE Cuidador ADD CONSTRAINT checkApe
CHECK (
		(
			ApellidoPaterno IS NOT NULL
			OR ApellidoMaterno IS NOT NULL
		)
	);
ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d5
CHECK(Calle <> '');
ALTER TABLE Cuidador ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN NumExterior SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d6
CHECK(Colonia <> '');
ALTER TABLE Cuidador ALTER COLUMN Colonia SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d7
CHECK(Estado <> ''
	AND Estado LIKE '%[a-zA-Z]%');
ALTER TABLE Cuidador ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN FechaInicioContrato SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN FechaFinContrato SET NOT NULL;
ALTER TABLE Cuidador ALTER COLUMN FechaNacimiento SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d8
CHECK(Genero <> ''
	AND Genero LIKE '%[a-zA-Z]%');
ALTER TABLE Cuidador ALTER COLUMN Genero SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d9
CHECK(DiasTrabajo > 0
	AND DiasTrabajo < 30);
ALTER TABLE Cuidador ALTER COLUMN DiasTrabajo SET NOT NULL;	
	
ALTER TABLE Cuidador ALTER COLUMN HorarioLaboral SET NOT NULL;

ALTER TABLE Cuidador ADD CONSTRAINT cuidador_d11
CHECK(Salario > 0);
ALTER TABLE Cuidador ALTER COLUMN Salario SET NOT NULL;
 



--LLAVES Cuidador
ALTER TABLE Cuidador ADD CONSTRAINT cuidador_pk
PRIMARY KEY(RFCCuidador);

ALTER TABLE Cuidador ADD CONSTRAINT idbioma_pk
FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma);


CREATE TABLE Animal(
	IDAnimal SERIAL,
	IDBioma SERIAL,
	IDJaula SERIAL,
	NombreAnimal VARCHAR(50),
	Sexo VARCHAR(50),
	Altura DECIMAL,
	Peso DECIMAL,
	Especie VARCHAR(50),
	Alimentacion VARCHAR(50)
);


-- RESTRICCIONES DE DOMINIO Animal
ALTER TABLE Animal ADD CONSTRAINT animal_d1
CHECK (NombreAnimal <> ''
		AND NombreAnimal LIKE '%[a-zA-Z]%');
ALTER TABLE Animal ALTER COLUMN NombreAnimal SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT animal_d2
CHECK (Sexo IN ('macho', 'hembra'));
ALTER TABLE Animal ALTER COLUMN Sexo SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT animal_d3
CHECK (Altura > 0);
ALTER TABLE Animal ALTER COLUMN Altura SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT animal_d4
CHECK (Peso > 0);
ALTER TABLE Animal ALTER COLUMN Peso SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT animal_d5
CHECK (Especie <> ''
		AND Especie LIKE '%[a-zA-Z]%');
ALTER TABLE Animal ALTER COLUMN Especie SET NOT NULL;

ALTER TABLE Animal ADD CONSTRAINT animal_d7
CHECK (
		Alimentacion IN (
			'carnívoro',
			'herbívoro',
			'omnívoro'));
ALTER TABLE Animal ALTER COLUMN Alimentacion SET NOT NULL;

-- LLAVES Animal
ALTER TABLE Animal ADD CONSTRAINT animal_pk
PRIMARY KEY(IDAnimal);

ALTER TABLE Animal ADD CONSTRAINT idbioma_fk
FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma);

ALTER TABLE Animal ADD CONSTRAINT idjaula_fk
FOREIGN KEY (IDJaula) REFERENCES Jaula (IDJaula);

		


CREATE TABLE Evento(
	IDEvento SERIAL,
	IDVisitante SERIAL,
	TipoEvento VARCHAR(50),
	Fecha DATE,
	Capacidad INT
); 

-- RESTRICCIONES DE DOMINIO Evento
ALTER TABLE Evento ADD CONSTRAINT evento_d1
CHECK(TipoEvento <> '');
ALTER TABLE Evento ALTER COLUMN TipoEvento SET NOT NULL;

ALTER TABLE Evento ALTER COLUMN Fecha SET NOT NULL;

ALTER TABLE Evento ADD CONSTRAINT evento_d2
CHECK(Capacidad > 0);

ALTER TABLE Evento ALTER COLUMN Capacidad SET NOT NULL;

--LLAVES Evento
ALTER TABLE Evento ADD CONSTRAINT evento_pk
PRIMARY KEY(IDEvento);

ALTER TABLE Evento ADD CONSTRAINT idvisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante (IDVisitante);


CREATE TABLE Ticket(
	NumTicket SERIAL,
	IDVisitante SERIAL,
	Descuento INT,
	CostoUnitario DECIMAL,
	TipoServicio VARCHAR(50),
	Fecha DATE
);


-- RESTRICCIONES DE DOMINIO Ticket
ALTER TABLE Ticket ADD CONSTRAINT ticket_d1
CHECK (Descuento >= 0
	AND Descuento <= 100);
ALTER TABLE Ticket ALTER COLUMN Descuento SET NOT NULL;

ALTER TABLE Ticket ADD CONSTRAINT ticket_d2
CHECK (CostoUnitario > 0);
ALTER TABLE Ticket ALTER COLUMN CostoUnitario SET NOT NULL;

ALTER TABLE Ticket ADD CONSTRAINT ticket_d3
CHECK (TipoServicio IN ('baño', 'tienda', 'comida'));
ALTER TABLE Ticket ALTER COLUMN TipoServicio SET NOT NULL;

ALTER TABLE Ticket ALTER COLUMN Fecha SET NOT NULL;

--LLAVES Ticket
ALTER TABLE Ticket ADD CONSTRAINT ticket_pk
PRIMARY KEY(NumTicket);

ALTER TABLE Ticket ADD CONSTRAINT idvisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante (IDVisitante);



CREATE TABLE ProveerMedicina(
	IDInsumoMedicina SERIAL,
	RFCProveedor VARCHAR(13)
);

-- RESTRICCIONES DE DOMINIO ProveerMedicina
ALTER TABLE ProveerMedicina ADD CONSTRAINT proveerMedicina_d1
 CHECK (
		RFCProveedor <> ''
		AND (
			LENGTH(RFCProveedor) = 13
			OR LENGTH(RFCProveedor) = 12
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE ProveerMedicina ALTER COLUMN RFCProveedor SET NOT NULL;


-- LLAVES ProveerMedicina
ALTER TABLE ProveerMedicina ADD CONSTRAINT rfcProveedor_fk
FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor);

ALTER TABLE ProveerMedicina ADD CONSTRAINT idinsumoMedicina_fk
FOREIGN KEY (IDInsumoMedicina) REFERENCES Medicina(IDInsumoMedicina);


CREATE TABLE Notificar(
	idEvento SERIAL,
	IDVisitante SERIAL,
	TipoNotificacion VARCHAR(50)
	
);

-- RESTRICCIONES DE DOMINIO Notificar
ALTER TABLE Notificar ADD CONSTRAINT notificar_d1
CHECK (TipoNotificacion <> '');
ALTER TABLE Notificar ALTER COLUMN TipoNotificacion SET NOT NULL;

--LLAVES DE Notificar
ALTER TABLE Notificar ADD CONSTRAINT idevento_fk
FOREIGN KEY (idEvento) REFERENCES Evento(idEvento);

ALTER TABLE Notificar ADD CONSTRAINT idvisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante(IDVisitante);


CREATE TABLE Trabajar(
	RFCVeterinario VARCHAR(13),
	IDBioma SERIAL
);

-- RESTRICCIONES DE DOMINIO Trabajar
ALTER TABLE Trabajar ADD CONSTRAINT trabajar_d1
CHECK (
		RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Trabajar ALTER COLUMN RFCVeterinario SET NOT NULL;

-- LLAVES Trabajar
ALTER TABLE Trabajar ADD CONSTRAINT rfcveterinario_fk
FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario(RFCVeterinario);

ALTER TABLE Trabajar ADD CONSTRAINT idBioma_fk
FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma);


CREATE TABLE DistribuirMedicina(
	IDInsumoMedicina SERIAL,
	IDBioma SERIAL
);

--LLAVES DistribuirMedicina
ALTER TABLE DistribuirMedicina ADD CONSTRAINT idinsumoMedicina_fk
FOREIGN KEY (IDInsumoMedicina) REFERENCES Medicina (IDInsumoMedicina);

ALTER TABLE DistribuirMedicina ADD CONSTRAINT idbioma_fk
FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma);


CREATE TABLE Cuidar (
	RFCCuidador VARCHAR(13),
	IDAnimal SERIAL,
	Nombre VARCHAR(50),
	ApellidoPaterno VARCHAR(50),
	ApellidoMaterno VARCHAR(50),
	Calle VARCHAR(50),
	NumInterior INT,
	NumExterior INT,
	Colonia VARCHAR(50),
	Estado VARCHAR(50),
	FechaInicioContrato DATE,
	FechaFinContrato DATE,
	FechaNacimiento DATE,
	DiasTrabajo INT,
	HorarioLaboral TIME,
	Salario DECIMAL,
	Genero VARCHAR(10),
	Sexo VARCHAR(10),
	Altura DECIMAL,
	Peso DECIMAL,
	Especie VARCHAR(50),
	NombreAnimal VARCHAR(50),
	Alimentacion VARCHAR(50)
	
);

-- RESTRICCIONES DE DOMINIO Cuidar
ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d1
CHECK ( RFCCuidador <> '' 
	AND (LENGTH(RFCCuidador) = 13 OR LENGTH(RFCCuidador) = 12)
	AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Cuidar ALTER COLUMN RFCCuidador SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d2
CHECK(Nombre <> ''
	AND Nombre LIKE '%[a-zA-Z]%');
ALTER TABLE Cuidar ALTER COLUMN Nombre SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d3
CHECK(ApellidoPaterno <> ''
	AND ApellidoPaterno LIKE '%[a-zA-Z]%');

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d4
CHECK(ApellidoMaterno <> ''
	AND ApellidoMaterno LIKE '%[a-zA-Z]%');

ALTER TABLE Cuidar ADD CONSTRAINT checkApe
CHECK (
		(
			ApellidoPaterno IS NOT NULL
			OR ApellidoMaterno IS NOT NULL
		)
	);
ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d5
CHECK(Calle <> '');
ALTER TABLE Cuidar ALTER COLUMN Calle SET NOT NULL;
ALTER TABLE Cuidar ALTER COLUMN NumInterior SET NOT NULL;
ALTER TABLE Cuidar ALTER COLUMN NumExterior SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d6
CHECK(Colonia <> '');
ALTER TABLE Cuidar ALTER COLUMN Colonia SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d7
CHECK(Estado <> ''
	AND Estado LIKE '%[a-zA-Z]%');
ALTER TABLE Cuidar ALTER COLUMN Estado SET NOT NULL;
ALTER TABLE Cuidar ALTER COLUMN FechaInicioContrato SET NOT NULL;
ALTER TABLE Cuidar ALTER COLUMN FechaFinContrato SET NOT NULL;
ALTER TABLE Cuidar ALTER COLUMN FechaNacimiento SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d8
CHECK(Genero <> ''
	AND Genero LIKE '%[a-zA-Z]%');
ALTER TABLE Cuidar ALTER COLUMN Genero SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d9
CHECK(DiasTrabajo > 0
	AND DiasTrabajo < 30);
ALTER TABLE Cuidar ALTER COLUMN DiasTrabajo SET NOT NULL;	
	
ALTER TABLE Cuidar ALTER COLUMN HorarioLaboral SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d11
CHECK(Salario > 0);
ALTER TABLE Cuidar ALTER COLUMN Salario SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d12
CHECK (NombreAnimal <> ''
		AND NombreAnimal LIKE '%[a-zA-Z]%');
ALTER TABLE Cuidar ALTER COLUMN NombreAnimal SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d13
CHECK (Sexo IN ('macho', 'hembra'));
ALTER TABLE Cuidar ALTER COLUMN Sexo SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d14
CHECK (Altura > 0);
ALTER TABLE Cuidar ALTER COLUMN Altura SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d15
CHECK (Peso > 0);
ALTER TABLE Cuidar ALTER COLUMN Peso SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d16
CHECK (Especie <> ''
		AND Especie LIKE '%[a-zA-Z]%');
ALTER TABLE Cuidar ALTER COLUMN Especie SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d17
CHECK (Edad > 0);
ALTER TABLE Cuidar ALTER COLUMN Edad SET NOT NULL;

ALTER TABLE Cuidar ADD CONSTRAINT cuidar_d18
CHECK (
		Alimentacion IN (
			'carnívoro',
			'herbívoro',
			'omnívoro'));
ALTER TABLE Cuidar ALTER COLUMN Alimentacion SET NOT NULL;

-- LLAVES Cuidar
ALTER TABLE Cuidar ADD CONSTRAINT rfcCuidador_fk
FOREIGN KEY (RFCCuidador) REFERENCES Cuidador (RFCCuidador);

ALTER TABLE Cuidar ADD CONSTRAINT idanimal_fk
FOREIGN KEY (IDAnimal) REFERENCES Animal (IDAnimal);
 


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


CREATE TABLE Tener(
	IDBioma SERIAL,
	IDServicio SERIAL,
	CONSTRAINT fk_idbioma FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma),
	CONSTRAINT fk_idservicio FOREIGN KEY (IDServicio) REFERENCES Servicio (IDServicio)
);


CREATE TABLE Atender(
	IDAnimal SERIAL,
	IndicacionesMedicas Text NOT NULL CHECK (
		IndicacionesMedicas <> ''
		AND IndicacionesMedicas LIKE '%[a-zA-Z]%'
	),
	RFCVeterinario VARCHAR(13) NOT NULL CHECK (
		RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	FOREIGN KEY (IDAnimal) REFERENCES Animal (IDAnimal),
	FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario (RFCVeterinario)
);


------------------------------Telefonos y correos -------------------------------------

CREATE TABLE TelefonoVisitante(
	IDVisitante SERIAL,
	Telefono CHAR(10) NOT NULL CHECK(Telefono SIMILAR TO '[0-9]+'),
	PRIMARY KEY(IDVisitante, Telefono),
	FOREIGN KEY (IDVisitante) REFERENCES Visitante(IDVisitante)
);


CREATE TABLE TelefonoProveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK (
		RFCProveedor <> ''
		AND (
			LENGTH(RFCProveedor) = 13
			OR LENGTH(RFCProveedor) = 12
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Telefono CHAR(10) NOT NULL CHECK(Telefono SIMILAR TO '[0-9]+'),
	PRIMARY KEY(RFCProveedor, Telefono),
	FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor)
);


CREATE TABLE CorreoProveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK (
		RFCProveedor <> ''
		AND (
			LENGTH(RFCProveedor) = 13
			OR LENGTH(RFCProveedor) = 12
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Correo VARCHAR(50) NOT NULL CHECK(Correo LIKE '%_@_%._%'),
	PRIMARY KEY(RFCProveedor, Correo),
	FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor)
);


CREATE TABLE CorreoVeterinario(
	RFCVeterinario VARCHAR(13) NOT NULL CHECK (
		RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Correo VARCHAR(50) CHECK (
		Correo LIKE '%_@_%._%'
		AND Correo <> ''
	),
	PRIMARY KEY(RFCVeterinario, Correo),
	FOREIGN KEY(RFCVeterinario) REFERENCES Veterinario(RFCVeterinario)
);


CREATE TABLE TelefonoVeterinario(
	RFCVeterinario VARCHAR(13) NOT NULL CHECK (
		RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Telefono CHAR(10) CHECK(
		Telefono ~ '^[0-9 ]*$'
		AND Telefono <> ''
	),
	PRIMARY KEY(RFCVeterinario, Telefono),
	FOREIGN KEY(RFCVeterinario) REFERENCES Veterinario(RFCVeterinario)
);


CREATE TABLE CorreoCuidador(
	RFCCuidador VARCHAR(13) NOT NULL CHECK (
		RFCCuidador <> ''
		AND (
			LENGTH(RFCCuidador) = 13
			OR LENGTH(RFCCuidador) = 12
		)
		AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Correo VARCHAR(50) CHECK(
		Correo LIKE '%@%._%'
		AND Correo <> ''
	),
	PRIMARY KEY(RFCCuidador, Correo),
	FOREIGN KEY(RFCCuidador) REFERENCES Cuidador(RFCCuidador)
);


CREATE TABLE TelefonoCuidador(
	RFCCuidador VARCHAR(13) NOT NULL CHECK (
		RFCCuidador <> ''
		AND (
			LENGTH(RFCCuidador) = 13
			OR LENGTH(RFCCuidador) = 12
		)
		AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}'
	),
	Telefono CHAR(10) CHECK(
		Telefono ~ '^[0-9 ] *$'
		AND Telefono <> ''
	),
	PRIMARY KEY(RFCCuidador, Telefono),
	FOREIGN KEY(RFCCuidador) REFERENCES Cuidador(RFCCuidador)
);


CREATE TABLE CorreoVisitante (
	IDVisitante SERIAL,
	Correo VARCHAR(50) CHECK(
		Correo LIKE '%@%._%'
		AND Correo <> ''
	),
	PRIMARY KEY(IdVisitante, Correo),
	FOREIGN KEY(IDVisitante) REFERENCES Visitante(IDVisitante)
);

CREATE TABLE Visitar(
	IDEvento SERIAL,
	IDVisitante SERIAL,
	FOREIGN KEY (IDEvento) REFERENCES Evento(IDEvento),
	FOREIGN KEY (IDVisitante) REFERENCES Visitante(IDVisitante)
);
