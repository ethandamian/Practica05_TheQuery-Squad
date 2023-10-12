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
);

--------TABLAS CON LLAVES PRIMARIAS-----------------
CREATE TABLE CorreoVeterinario(
	RFCVeterinario VARCHAR(13) CHECK(LENGTH(RFCVeterinario) = 13 OR LENGTH(RFCVeterinario) = 12
									 AND RFCVeterinario <> ''),
	Correo VARCHAR(50)  CHECK (Correo LIKE '%_@_%._%' AND Correo <> ''),
	PRIMARY KEY(RFCVeterinario,Correo)
);

CREATE TABLE TelefonoVeterinario(
	RFCVeterinario VARCHAR(13) CHECK(LENGTH(RFCVeterinario) = 13 OR LENGTH(RFCVeterinario) = 12 
									 AND RFCVeterinario <> ''),
	Telefono CHAR(10) CHECK(Telefono ~ '^[0-9 ]*$' AND Telefono <> ''),
	PRIMARY KEY(RFCVeterinario,Telefono)

);
