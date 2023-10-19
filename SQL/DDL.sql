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

-- COMMENTS DE Veterinario 

COMMENT ON TABLE Veterinario IS 'Tabla Veterinario';
COMMENT ON COLUMN Veterinario.RFCVeterinario IS 'RFC del Veterinario';
COMMENT ON COLUMN Veterinario.Nombre IS 'Nombre del Veterinario';
COMMENT ON COLUMN Veterinario.ApellidoPaterno IS 'Apellido Paterno del Veterinario';
COMMENT ON COLUMN Veterinario.ApellidoMaterno IS 'Apellido Materno del Veterinario';
COMMENT ON COLUMN Veterinario.Calle IS 'La calle donde vive el Veterinario';
COMMENT ON COLUMN Veterinario.NumInterior IS 'Numero Interior de la direccion de el Veterinario';
COMMENT ON COLUMN Veterinario.NumExterior IS 'Numero Exterior de la direccion de el Veterinario';
COMMENT ON COLUMN Veterinario.Colonia IS 'La colonia de la direccion de el Veterinario';
COMMENT ON COLUMN Veterinario.Estado IS 'El Estado de la direccion donde vive el Veterinario';
COMMENT ON COLUMN Veterinario.FechaInicioContrato IS 'Fecha cuando inicio el contrato de el Veterinario';
COMMENT ON COLUMN Veterinario.FechaFinContrato IS 'Fecha cuando finalizo el contrato de el Veterinario';
COMMENT ON COLUMN Veterinario.FechaNacimiento IS 'Fecha de nacimiento del Veterinario';
COMMENT ON COLUMN Veterinario.Genero IS 'Género del Veterinario';
COMMENT ON COLUMN Veterinario.Salario IS 'Salario del Veterinario';
COMMENT ON COLUMN Veterinario.Especialidad IS 'Especialidad del Veterinario';
COMMENT ON CONSTRAINT veterinario_d1 ON Veterinario IS 
'Restriccion para RFC:Longitud de 12 o 13, 4 caracteres letras, 6 numeros, 2 o 3 letras o numeros';
COMMENT ON CONSTRAINT veterinario_d2 ON Veterinario IS
'Restriccion para Nombre: Debe contener solo letras';
COMMENT ON CONSTRAINT veterinario_d3 ON Veterinario IS
'Restriccion para el Apellido Paterno: Debe contener solo letras';
COMMENT ON CONSTRAINT veterinario_d4 ON Veterinario IS
'Restriccion para el Apellido Materno: Debe contener solo letras';
COMMENT ON CONSTRAINT checkApe ON Veterinario IS
'El Veterinario puede no tener apellido paterno o materno';
COMMENT ON CONSTRAINT veterinario_d5 ON Veterinario IS
'Restriccion para Calle: No debe ser la cadena vacia';
COMMENT ON CONSTRAINT veterinario_d6 ON Veterinario IS
'Restriccion para Colonia: No debe ser la cadena vacia';
COMMENT ON CONSTRAINT veterinario_d7 ON Veterinario IS
'Restriccion para Estado: No debe ser la cadena vacia y debe contener solo letras';

COMMENT ON CONSTRAINT veterinario_d8 ON Veterinario IS
'Restriccion para Genero: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT veterinario_d9 ON Veterinario IS
'Restriccion para Salario: Debe ser mayor a 0';
COMMENT ON CONSTRAINT veterinario_d10 ON Veterinario IS
'Restriccion para Especialidad: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT veterinario_pk ON Veterinario IS
'Llave primaria de Veterinario';




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

-- COMMENT DE Visitante
COMMENT ON TABLE Visitante IS 'Tabla Visitante';
COMMENT ON COLUMN Visitante.IDVisitante IS 'Columna id del Visitante';
COMMENT ON COLUMN Visitante.Genero IS 'Genero del Visitante';
COMMENT ON COLUMN Visitante.Nombre IS 'Nombre del Visitante';
COMMENT ON COLUMN Visitante.Paterno IS 'Apellido Paterno del Visitante';
COMMENT ON COLUMN Visitante.Materno IS 'Apellido Materno del Visitante';

COMMENT ON CONSTRAINT visitante_d1 ON Visitante IS 
'Restriccion en Genero: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT visitante_d2 ON Visitante IS
'Restriccion en Nombre: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT visitante_d3 ON Visitante IS
'Restriccion en Paterno: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT visitante_d4 ON Visitante IS
'Restriccion en Materno: No debe ser la cadena vacia y debe contener solo letras';
COMMENT ON CONSTRAINT checkApe ON Visitante IS
'Restriccion en Apellidos: El Visitante puede no tener apellido paterno o materno';
COMMENT ON CONSTRAINT visitante_pk ON Visitante IS
'Llave primaria de Visitante';


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

--COMMENT DE Jaula
COMMENT ON TABLE Jaula IS 'Tabla Jaula';
COMMENT ON COLUMN Jaula.IDJaula IS 'Columna ID de la Jaula';
COMMENT ON CONSTRAINT jaula_pk ON Jaula IS
'Llave primaria de Jaula';

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
	IDServicio SERIAL
);

--LLAVES Comprar
ALTER TABLE Comprar ADD CONSTRAINT idvisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante (IDVisitante);

ALTER TABLE Comprar ADD CONSTRAINT idservicio_fk
FOREIGN KEY (IDServicio) REFERENCES Servicio (IDServicio);





CREATE TABLE ProveerAlimento(
	IDInsumoAlimento SERIAL,
	RFCProveedor VARCHAR(13)
);

-- LLAVES ProveerAlimento
ALTER TABLE ProveerAlimento ADD CONSTRAINT idinsumoAlimento_fk
FOREIGN KEY (IDInsumoAlimento) REFERENCES Alimento (IDInsumoAlimento);

ALTER TABLE ProveerAlimento ADD CONSTRAINT rfcProveedor_fk
FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor);


CREATE TABLE DistribuirAlimento(
	IDInsumoAlimento SERIAL,
	IDBioma SERIAL
	
);


-- LLAVES DistribuirAlimento
ALTER TABLE DistribuirAlimento ADD CONSTRAINT idinsumoAlimento_fk
FOREIGN KEY (IDInsumoAlimento) REFERENCES Alimento (IDInsumoAlimento);

ALTER TABLE DistribuirAlimento ADD CONSTRAINT idbioma_fk
FOREIGN KEY (IDBioma) REFERENCES Bioma(IDBioma);


CREATE TABLE Tener(
	IDBioma SERIAL,
	IDServicio SERIAL
	
);

-- LLAVES Tener
ALTER TABLE Tener ADD CONSTRAINT idbioma_fk
FOREIGN KEY (IDBioma) REFERENCES Bioma (IDBioma)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Tener ADD CONSTRAINT idservicio_fk
FOREIGN KEY (IDServicio) REFERENCES Servicio (IDServicio)
ON UPDATE CASCADE ON DELETE CASCADE;

-- COMMENT DE Tener
COMMENT ON TABLE Tener IS 'Tabla de relacion Tener';
COMMENT ON COLUMN Tener.IDBioma IS 'Columna Id de Bioma';
COMMENT ON COLUMN Tener.IDServicio IS 'Columna ID de Servicio';
COMMENT ON CONSTRAINT idbioma_fk ON Tener IS
'Llave foranea IDBioma referenciada de la tabla Bioma';
COMMENT ON CONSTRAINT idservicio_fk ON Tener IS
'Llve foranea IDServicio referenciada de la tabla Servicio';

CREATE TABLE Atender(
	IDAnimal SERIAL,
	IndicacionesMedicas Text,
	RFCVeterinario VARCHAR(13)
	
);

-- RESTRICCIONES DE DOMINIO Atender
ALTER TABLE Atender ADD CONSTRAINT atender_d1
CHECK (IndicacionesMedicas <> ''
		AND IndicacionesMedicas LIKE '%[a-zA-Z]%');
ALTER TABLE Atender ALTER COLUMN IndicacionesMedicas SET NOT NULL;

ALTER TABLE Atender ADD CONSTRAINT atender_d2
CHECK (RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE Atender ALTER COLUMN RFCVeterinario SET NOT NULL;

-- LLAVES Atender
ALTER TABLE Atender ADD CONSTRAINT idanimal_fk
FOREIGN KEY (IDAnimal) REFERENCES Animal (IDAnimal);

ALTER TABLE Atender ADD CONSTRAINT rfcVeterinario_fk
FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario (RFCVeterinario);

------------------------------Telefonos y correos -------------------------------------

CREATE TABLE TelefonoVisitante(
	IDVisitante SERIAL,
	Telefono CHAR(10)
	
);

-- RESTRICCIONES DE DOMINIO TelefonoVisitante
ALTER TABLE TelefonoVisitante ADD CONSTRAINT telefonoVisitante_d1
CHECK(Telefono SIMILAR TO '[0-9]+');
ALTER TABLE TelefonoVisitante ALTER COLUMN Telefono SET NOT NULL;

-- LLAVES TelefonoVisitante
ALTER TABLE TelefonoVisitante ADD CONSTRAINT telefonoVisitante_pk
PRIMARY KEY(IDVisitante, Telefono);

ALTER TABLE TelefonoVisitante ADD CONSTRAINT idVisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante(IDVisitante);



CREATE TABLE TelefonoProveedor(
	RFCProveedor VARCHAR(13),
	Telefono CHAR(10)
);


-- RESTRICCIONES DE DOMINIO TelefonoProveedor
ALTER TABLE TelefonoProveedor ADD CONSTRAINT telefonoProveedor_d1
CHECK(Telefono SIMILAR TO '[0-9]+');
ALTER TABLE TelefonoProveedor ALTER COLUMN Telefono SET NOT NULL;

ALTER TABLE TelefonoProveedor ADD CONSTRAINT telefonoProveedor_d2
CHECK (
		RFCProveedor <> ''
		AND (
			LENGTH(RFCProveedor) = 13
			OR LENGTH(RFCProveedor) = 12
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE TelefonoProveedor ALTER COLUMN RFCProveedor SET NOT NULL;

-- LLAVES TelefonoProveedor
ALTER TABLE TelefonoProveedor ADD CONSTRAINT telefonoProveedor_pk
PRIMARY KEY(RFCProveedor, Telefono);

ALTER TABLE TelefonoProveedor ADD CONSTRAINT rfcProveedor_fk
FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor);


CREATE TABLE CorreoProveedor(
	RFCProveedor VARCHAR(13),
	Correo VARCHAR(50)
);

-- RESTRICCIONES DE DOMINIO CorreoProveedor
ALTER TABLE CorreoProveedor ADD CONSTRAINT correoProveedor_d1
CHECK (
		RFCProveedor <> ''
		AND (
			LENGTH(RFCProveedor) = 13
			OR LENGTH(RFCProveedor) = 12
		)
		AND RFCProveedor SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE CorreoProveedor ALTER COLUMN RFCProveedor SET NOT NULL;	

ALTER TABLE CorreoProveedor ADD CONSTRAINT correoProveedor_d2
CHECK(Correo LIKE '%_@_%._%');
ALTER TABLE CorreoProveedor ALTER COLUMN Correo SET NOT NULL;

-- LLAVES DE CorreoProveedor
ALTER TABLE CorreoProveedor ADD CONSTRAINT correoProveedor_pk
PRIMARY KEY(RFCProveedor, Correo);

ALTER TABLE CorreoProveedor ADD CONSTRAINT rfcProveedor_fk
FOREIGN KEY (RFCProveedor) REFERENCES Proveedor(RFCProveedor);


CREATE TABLE CorreoVeterinario(
	RFCVeterinario VARCHAR(13),
	Correo VARCHAR(50)
);

-- RESTRICCIONES DE DOMINIO CorreoVeterinario
ALTER TABLE CorreoVeterinario ADD CONSTRAINT correoVeterinario_d1
CHECK (
		RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE CorreoVeterinario ALTER COLUMN RFCVeterinario SET NOT NULL;	

ALTER TABLE CorreoVeterinario ADD CONSTRAINT correoVeterinario_d2
CHECK(Correo LIKE '%_@_%._%');
ALTER TABLE CorreoVeterinario ALTER COLUMN Correo SET NOT NULL;

-- LLAVES DE CorreoVeterinario
ALTER TABLE CorreoVeterinario ADD CONSTRAINT correoVeterinario_pk
PRIMARY KEY(RFCVeterinario, Correo);

ALTER TABLE CorreoVeterinario ADD CONSTRAINT rfcVeterinario_fk
FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario(RFCVeterinario);


CREATE TABLE TelefonoVeterinario(
	RFCVeterinario VARCHAR(13),
	Telefono CHAR(10)
);


-- RESTRICCIONES DE DOMINIO TelefonoVeterinario
ALTER TABLE TelefonoVeterinario ADD CONSTRAINT telefonoVeterinario_d1
CHECK(Telefono SIMILAR TO '[0-9]+');
ALTER TABLE TelefonoVeterinario ALTER COLUMN Telefono SET NOT NULL;

ALTER TABLE TelefonoVeterinario ADD CONSTRAINT telefonoVeterinario_d2
CHECK (
		RFCVeterinario <> ''
		AND (
			LENGTH(RFCVeterinario) = 13
			OR LENGTH(RFCVeterinario) = 12
		)
		AND RFCVeterinario SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE TelefonoVeterinario ALTER COLUMN RFCVeterinario SET NOT NULL;

-- LLAVES TelefonoVeterinario
ALTER TABLE TelefonoVeterinario ADD CONSTRAINT telefonoVeterinario_pk
PRIMARY KEY(RFCVeterinario, Telefono);

ALTER TABLE TelefonoVeterinario ADD CONSTRAINT rfcVeterinario_fk
FOREIGN KEY (RFCVeterinario) REFERENCES Veterinario(RFCVeterinario) 
ON UPDATE CASCADE ON DELETE CASCADE;

-- COMMENTS DE TelefonoVeterinario
COMMENT ON TABLE TelefonoVeterinario IS 'Tabla que contiene los telefonos de los Veterinarios';
COMMENT ON COLUMN TelefonoVeterinario.RFCVeterinario IS 'Identificador(RFC) del Veterinario';
COMMENT ON COLUMN TelefonoVeterinario.Telefono IS 'El telefono del Veterinario';
COMMENT ON CONSTRAINT telefonoVeterinario_d1 ON TelefonoVeterinario IS 
'Restriccion para el telefono: La cadena solo puede contener numeros';
COMMENT ON CONSTRAINT telefonoVeterinario_d2 ON TelefonoVeterinario IS 
'Restriccion para RFC: Longitud de 12 o 13, 4 caracteres letras, 6 numeros, 2 o 3 letras o numeros';
COMMENT ON CONSTRAINT telefonoVeterinario_pk ON TelefonoVeterinario IS
'Llave primaria de TelefonoVeterinario';
COMMENT ON CONSTRAINT rfcVeterinario_fk ON TelefonoVeterinario IS
'Lave foranea de TelefonoVeterinario, referenciada de la tabla Veterinario';



CREATE TABLE CorreoCuidador(
	RFCCuidador VARCHAR(13),
	Correo VARCHAR(50)
);

-- RESTRICCIONES DE DOMINIO CorreoCuidador
ALTER TABLE CorreoCuidador ADD CONSTRAINT correoCuidador_d1
CHECK (
		RFCCuidador <> ''
		AND (
			LENGTH(RFCCuidador) = 13
			OR LENGTH(RFCCuidador) = 12
		)
		AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE CorreoCuidador ALTER COLUMN RFCCuidador SET NOT NULL;	

ALTER TABLE CorreoCuidador ADD CONSTRAINT correoCuidador_d2
CHECK(Correo LIKE '%_@_%._%');
ALTER TABLE CorreoCuidador ALTER COLUMN Correo SET NOT NULL;

-- LLAVES DE CorreoCuidador
ALTER TABLE CorreoCuidador ADD CONSTRAINT correoCuidador_pk
PRIMARY KEY(RFCCuidador, Correo);

ALTER TABLE CorreoCuidador ADD CONSTRAINT rfcCuidador_fk
FOREIGN KEY (RFCCuidador) REFERENCES Cuidador(RFCCuidador)
ON UPDATE CASCADE ON DELETE CASCADE;

--COMENTS DE CorreoCuidador
COMMENT ON TABLE CorreoCuidador IS 'Tabla que contiene el correo del cuidador';
COMMENT ON COLUMN CorreoCuidador.RFCCuidador IS 'RFC del Cuidador';
COMMENT ON COLUMN CorreoCuidador.Correo IS 'Correo del Cuidador';

COMMENT ON CONSTRAINT correoCuidador_d1 ON CorreoCuidador IS
'Restriccion para RFC: Longitud de 12 o 13, 4 caracteres letras, 6 numeros, 2 o 3 letras o numeros';
COMMENT ON CONSTRAINT correoCuidador_d2 ON CorreoCuidador IS
'Restriccion para Correo: Tiene que ser de la forma [caracteres]@[caracteres].[dominio]';
COMMENT ON CONSTRAINT correoCuidador_pk ON CorreoCuidador IS
'Llave primaria de CorreoCuidador';
COMMENT ON CONSTRAINT rfcCuidador_fk ON CorreoCuidador IS
'Llave foranea de CorreoCuidador referenciada de la tabla Cuidador';



CREATE TABLE TelefonoCuidador(
	RFCCuidador VARCHAR(13),
	Telefono CHAR(10)
);


-- RESTRICCIONES DE DOMINIO TelefonoCuidador
ALTER TABLE TelefonoCuidador ADD CONSTRAINT telefonoCuidador_d1
CHECK(Telefono SIMILAR TO '[0-9]+');
ALTER TABLE TelefonoCuidador ALTER COLUMN Telefono SET NOT NULL;

ALTER TABLE TelefonoCuidador ADD CONSTRAINT telefonoCuidador_d2
CHECK (
		RFCCuidador <> ''
		AND (
			LENGTH(RFCCuidador) = 13
			OR LENGTH(RFCCuidador) = 12
		)
		AND RFCCuidador SIMILAR TO '[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}');
ALTER TABLE TelefonoCuidador ALTER COLUMN RFCCuidador SET NOT NULL;

-- LLAVES TelefonoVeterinario
ALTER TABLE TelefonoCuidador ADD CONSTRAINT telefonoCuidador_pk
PRIMARY KEY(RFCCuidador, Telefono);

ALTER TABLE TelefonoCuidador ADD CONSTRAINT rfcCuidador_fk
FOREIGN KEY (RFCCuidador) REFERENCES Cuidador(RFCCuidador);


CREATE TABLE CorreoVisitante (
	IDVisitante SERIAL,
	Correo VARCHAR(50)
);

--RESTRICCIONES DE DOMINIO CorreoVisitante
ALTER TABLE CorreoVisitante ADD CONSTRAINT correoVisitante_d1
CHECK(Correo LIKE '%@%._%'
	AND Correo <> '');

-- LLAVES CorreoVisitante
ALTER TABLE CorreoVisitante ADD CONSTRAINT correoVisitante_pk
PRIMARY KEY(IdVisitante, Correo);

ALTER TABLE CorreoVisitante ADD CONSTRAINT idVisitante_fk
FOREIGN KEY(IDVisitante) REFERENCES Visitante(IDVisitante);

CREATE TABLE Visitar(
	IDEvento SERIAL,
	IDVisitante SERIAL
);

-- LLAVES Visitar
ALTER TABLE Visitar ADD CONSTRAINT idEvento_fk
FOREIGN KEY (IDEvento) REFERENCES Evento(IDEvento);

ALTER TABLE Visitar ADD CONSTRAINT idVisitante_fk
FOREIGN KEY (IDVisitante) REFERENCES Visitante(IDVisitante);




