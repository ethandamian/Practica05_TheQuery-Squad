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
	RFCProveedor VARCHAR(13) NOT NULL CHECK(RFCProveedor <> ''),
	Telefono CHAR(10) NOT NULL CHECK(Telefono SIMILAR TO '[0-9]+'),
	PRIMARY KEY(RFCProveedor, Telefono)
);

CREATE TABLE CorreoProveedor(
	RFCProveedor VARCHAR(13) NOT NULL CHECK(RFCProveedor <> ''),
	Correo VARCHAR(50) NOT NULL CHECK(Correo LIKE '%_@_%._%' ),
	PRIMARY KEY(RFCProveedor, Correo)
);

CREATE TABLE ProveerMedicina(
	IDInsumoMedicina serial NOT NULL CHECK(IDInsumoMedicina>0),
	RFCProveedor VARCHAR(13) NOT NULL CHECK(RFCProveedor <> '')
);



