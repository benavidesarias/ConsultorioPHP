
-- Se debe crear previamente un esquema llamado "consultorio" 
-- con password "consultorio777." (termina en punto)
-- en este esquema ejecutar el siguiente script

CREATE TABLE  "CONSULTORIOS" 
   (
   	"CONNUMERO" NUMBER NOT NULL ENABLE, 
	"CONNOMBRE" VARCHAR2(50) NOT NULL ENABLE, 
	 CONSTRAINT "CONSULTORIOS_PK" PRIMARY KEY ("CONNUMERO") ENABLE
   )
/
CREATE TABLE  "MEDICOS" 
   (
   	"MEDIDENTIFICACION" NUMBER NOT NULL ENABLE, 
	"MEDNOMBRE" VARCHAR2(30) NOT NULL ENABLE, 
	"MEDAPELLIDOS" VARCHAR2(30) NOT NULL ENABLE, 
	 CONSTRAINT "MEDICOS_PK" PRIMARY KEY ("MEDIDENTIFICACION") ENABLE
   )
/
CREATE TABLE  "PACIENTES" 
   (
   	"PACIDENTIFICACION" NUMBER NOT NULL ENABLE, 
	"PACNOMBRES" VARCHAR2(30) NOT NULL ENABLE, 
	"PACAPELLIDOS" VARCHAR2(30) NOT NULL ENABLE, 
	"PACFECHANACIMIENTO" DATE NOT NULL ENABLE, 
	"PACSEXO" VARCHAR2(1) NOT NULL ENABLE, 
	 CONSTRAINT "PACIENTES_PK" PRIMARY KEY ("PACIDENTIFICACION") ENABLE, 
	 CONSTRAINT "PACIENTES_CK1" CHECK (PACSEXO IN ('M','F')) ENABLE
   )
/

CREATE TABLE  "CITAS" 
   (
   	"CITNUMERO" NUMBER NOT NULL ENABLE, 
	"CITFECHA" DATE NOT NULL ENABLE, 
	"CITHORA" DATE NOT NULL ENABLE, 
	"CITPACIENTE" NUMBER NOT NULL ENABLE, 
	"CITMEDICO" NUMBER NOT NULL ENABLE, 
	"CITCONSULTORIO" NUMBER NOT NULL ENABLE, 
	"CITESTADO" VARCHAR2(10) NOT NULL ENABLE, 
	"CITOBSERVACIONES" VARCHAR2(50) NOT NULL ENABLE, 
	 CONSTRAINT "CITAS_PK" PRIMARY KEY ("CITNUMERO") ENABLE, 
	 CONSTRAINT "CITAS_FK" FOREIGN KEY ("CITPACIENTE")
	  REFERENCES  "PACIENTES" ("PACIDENTIFICACION") ENABLE, 
	 CONSTRAINT "CITAS_FK2" FOREIGN KEY ("CITMEDICO")
	  REFERENCES  "MEDICOS" ("MEDIDENTIFICACION") ENABLE, 
	 CONSTRAINT "CITAS_FK3" FOREIGN KEY ("CITCONSULTORIO")
	  REFERENCES  "CONSULTORIOS" ("CONNUMERO") ENABLE
   )
/

CREATE TABLE  "HORAS" 
   (
   	"HORA" DATE NOT NULL ENABLE
   )
/

-- CREATE TABLE  "TABLA" 
--   (	"ID" NUMBER NOT NULL ENABLE, 
--	"VALOR" VARCHAR2(30) NOT NULL ENABLE, 
--	 CONSTRAINT "TABLA_PK" PRIMARY KEY ("ID") ENABLE
--    )
-- /
CREATE TABLE  "TRATAMIENTOS" 
   (
   	"TRANUMERO" NUMBER NOT NULL ENABLE, 
	"TRAFECHAASIGNADO" DATE NOT NULL ENABLE, 
	"TRADESCRIPCION" VARCHAR2(100) NOT NULL ENABLE, 
	"TRAFECHAINICIO" DATE NOT NULL ENABLE, 
	"TRAFECHAFIN" DATE NOT NULL ENABLE, 
	"TRAOBSERVACIONES" VARCHAR2(100) NOT NULL ENABLE, 
	"TRAPACIENTE" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "TRATAMIENTOS_PK" PRIMARY KEY ("TRANUMERO") ENABLE, 
	 CONSTRAINT "TRATAMIENTOS_FK" FOREIGN KEY ("TRAPACIENTE")
	  REFERENCES  "PACIENTES" ("PACIDENTIFICACION") ENABLE
   )
/

 CREATE TABLE "USUARIOS" 
   (	
    "ID" NUMBER NOT NULL ENABLE, 
	"USERNAME" VARCHAR2(20) NOT NULL ENABLE, 
	"PASSWORD" VARCHAR2(20) NOT NULL ENABLE, 
	"ROL" VARCHAR2(20) NOT NULL ENABLE, 
	 CONSTRAINT "USUARIOS_PK" PRIMARY KEY ("ID")
  )
/

-- CREATE UNIQUE INDEX  "CITAS_PK" ON  "CITAS" ("CITNUMERO")
-- /
-- CREATE UNIQUE INDEX  "CONSULTORIOS_PK" ON  "CONSULTORIOS" ("CONNUMERO")
-- /
-- CREATE UNIQUE INDEX  "MEDICOS_PK" ON  "MEDICOS" ("MEDIDENTIFICACION")
-- /
-- CREATE UNIQUE INDEX  "PACIENTES_PK" ON  "PACIENTES" ("PACIDENTIFICACION")
-- /
-- CREATE UNIQUE INDEX  "TRATAMIENTOS_PK" ON  "TRATAMIENTOS" ("TRANUMERO")
-- /
-- CREATE UNIQUE INDEX  "USUARIOS_PK" ON  "USUARIOS" ("ID")
-- /


CREATE SEQUENCE   "CITAS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE
/
 CREATE SEQUENCE   "CONSULTORIOS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE
/
 CREATE SEQUENCE   "TRATAMIENTOS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE
/
CREATE SEQUENCE   "USUARIOS_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE
/

CREATE OR REPLACE TRIGGER  "BI_CITAS" 
  before insert on "CITAS"               
  for each row  
begin   
    select "CITAS_SEQ".nextval into :NEW.CITNUMERO from dual; 
end; 

/
ALTER TRIGGER  "BI_CITAS" ENABLE
/

CREATE OR REPLACE TRIGGER  "BI_CONSULTORIOS" 
  before insert on "CONSULTORIOS"               
  for each row  
begin   
    select "CONSULTORIOS_SEQ".nextval into :NEW.CONNUMERO from dual; 
end; 

/
ALTER TRIGGER  "BI_CONSULTORIOS" ENABLE
/

CREATE OR REPLACE TRIGGER  "BI_TRATAMIENTOS" 
  before insert on "TRATAMIENTOS"               
  for each row  
begin   
    select "TRATAMIENTOS_SEQ".nextval into :NEW.TRANUMERO from dual; 
end; 

/
ALTER TRIGGER  "BI_TRATAMIENTOS" ENABLE
/

CREATE OR REPLACE TRIGGER  "BI_USUARIOS" 
  before insert on "USUARIOS"               
  for each row  
begin   
    select "USUARIOS_SEQ".nextval into :NEW.ID from dual; 
end;
/

ALTER TRIGGER  "BI_USUARIOS" ENABLE
/