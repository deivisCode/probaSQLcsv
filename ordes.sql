PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Definicions ;
DROP TABLE IF EXISTS Termos ;
DROP TABLE IF EXISTS AreasTematicas ;
DROP TABLE IF EXISTS Fontes ;

BEGIN TRANSACTION;

    CREATE TABLE IF NOT EXISTS Termos(
        id          INTEGER PRIMARY KEY,
        gl          TEXT NOT NULL UNIQUE,
        en          TEXT NOT NULL ,
        es          TEXT NOT NULL ,
        xenero      TEXT NOT NULL CHECK ( xenero      in ( 'femenino'       , 'masculino' , 'neutro'      ) ) ,
        clase       TEXT NOT NULL CHECK ( clase       in ( 'sustantivo'     , 'verbo'     , 'adxetivo'    ) ) ,
        numeros     TEXT NOT NULL CHECK ( numeros     in ( 'singular'       , 'plural'                    ) ) ,
        abreviacion TEXT NOT NULL CHECK ( abreviacion in ( 'forma completa' , 'siglas'    , 'abreviación' ) )
    );

    CREATE TABLE IF NOT EXISTS Definicions(
        id_definicion  INTEGER PRIMARY KEY,
        ext_definicion INTEGER NOT NULL,
        definicion     TEXT    NOT NULL,
        FOREIGN KEY (ext_definicion) REFERENCES Termos(id)
    );

    CREATE TABLE IF NOT EXISTS AreasTematicas(
        id_area  INTEGER PRIMARY KEY ,
        ext_area INTEGER NOT NULL ,
        area     TEXT    NOT NULL CHECK ( area in ( "area_1", "area_2", "area_3", "area_4" )),
        FOREIGN KEY (ext_area) REFERENCES Termos(id)
    );

    CREATE TABLE IF NOT EXISTS Fontes(
        id_fonte  INTEGER PRIMARY KEY ,
        ext_fonte INTEGER NOT NULL ,
        fonte     TEXT    NOT NULL ,
        FOREIGN KEY (ext_fonte) REFERENCES Termos(id)
    );

    CREATE TABLE IF NOT EXISTS Sinonimos(
        id_sinonimo  INTEGER PRIMARY KEY ,
        ext_sinonimo INTEGER NOT NULL ,
        sinonimo     INTEGER NOT NULL ,
        -- Non sei se estas claves estarán ben así
        -- Deberíase checkear que o resto de parámetros coincide, como xenero, clase, numeros, etc.
        FOREIGN KEY (ext_sinonimo) REFERENCES Termos(id),
        FOREIGN KEY (sinonimo) REFERENCES Termos(id)
    );

    CREATE TRIGGER probadefs
        BEFORE INSERT ON Definicions
        BEGIN
            SELECT CASE WHEN NEW.definicion = 'patata' THEN
                RAISE   (ABORT, "Non podes meter esa definicion")
            END;
        END;

    CREATE VIEW IF NOT EXISTS GlDefinicions AS
        SELECT
            gl, definicion
        FROM
            Termos
            INNER JOIN
            Definicions
            ON Definicions.ext_definicion = Termos.id
    ;

    CREATE VIEW IF NOT EXISTS EnDefinicions AS
        SELECT
            en, definicion
        FROM
            Termos
            INNER JOIN
            Definicions
            ON Definicions.ext_definicion = Termos.id
    ;

    CREATE VIEW IF NOT EXISTS EsDefinicions AS
        SELECT
            es, definicion
        FROM
            Termos
            INNER JOIN
            Definicions
            ON Definicions.ext_definicion = Termos.id
    ;

    -- INSERT INTO
    --     Sinonimos(ext_sinonimo, sinonimo)
    -- VALUES
    --     (5, 6), -- Termos con id 5, 6 e 7 son sinónimos
    --     (5, 7);

END TRANSACTION;
