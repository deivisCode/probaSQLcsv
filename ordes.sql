PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Definicions ;
DROP TABLE IF EXISTS Termos ;
DROP TABLE IF EXISTS AreasTematicas ;
DROP TABLE IF EXISTS Fontes ;

BEGIN TRANSACTION;

    CREATE TABLE IF NOT EXISTS Termos(
        id          INTEGER PRIMARY KEY,
        gl          TEXT NOT NULL UNIQUE, -- tal vez debería quitar a ligadura de 'unique' aqui e usar esto como clave foránea mellor
        en          TEXT NOT NULL ,
        es          TEXT NOT NULL ,
        xenero      TEXT NOT NULL CHECK ( xenero      in ( 'femenino'       , 'masculino' , 'neutro'      ) ) ,
        clase       TEXT NOT NULL CHECK ( clase       in ( 'sustantivo'     , 'verbo'     , 'adxetivo'    ) ) ,
        numeros     TEXT NOT NULL CHECK ( numeros     in ( 'singular'       , 'plural'                    ) ) ,
        abreviacion TEXT NOT NULL CHECK ( abreviacion in ( 'forma completa' , 'siglas'    , 'abreviación' ) )
    );

    CREATE TABLE IF NOT EXISTS Definicions(
        id            INTEGER PRIMARY KEY,
        id_definicion INTEGER NOT NULL,
        definicion    TEXT    NOT NULL,
        FOREIGN KEY (id_definicion) REFERENCES Termos(id)
    );

    CREATE TABLE IF NOT EXISTS AreasTematicas(
        id      INTEGER PRIMARY KEY ,
        id_area INTEGER NOT NULL ,
        area    TEXT    NOT NULL CHECK ( area in ( "area_1", "area_2", "area_3", "area_4" )),
        FOREIGN KEY (id_area) REFERENCES Termos(id)
    );

    CREATE TABLE IF NOT EXISTS Fontes(
        id       INTEGER PRIMARY KEY ,
        id_fonte INTEGER NOT NULL ,
        fonte    TEXT    NOT NULL ,
        FOREIGN KEY (id_fonte) REFERENCES Termos(id)
    );

    CREATE TABLE IF NOT EXISTS Sinonimos(
        id          INTEGER PRIMARY KEY ,
        id_sinonimo INTEGER NOT NULL ,
        sinonimo    INTEGER NOT NULL ,
        -- Non sei se estas claves estarán ben así
        -- Deberíase checkear que o resto de parámetros coincide, como xenero, clase, numeros, etc.
        FOREIGN KEY (id_sinonimo) REFERENCES Termos(id),
        FOREIGN KEY (sinonimo) REFERENCES Termos(id)
    );

    CREATE VIEW IF NOT EXISTS GlDefinicions AS
        SELECT
            gl, definicion
        FROM
            Termos
            INNER JOIN
            Definicions
            ON Definicions.id_definicion = Termos.id
    ;

    CREATE VIEW IF NOT EXISTS EnDefinicions AS
        SELECT
            en, definicion
        FROM
            Termos
            INNER JOIN
            Definicions
            ON Definicions.id_definicion = Termos.id
    ;

    CREATE VIEW IF NOT EXISTS EsDefinicions AS
        SELECT
            es, definicion
        FROM
            Termos
            INNER JOIN
            Definicions
            ON Definicions.id_definicion = Termos.id
    ;

    INSERT INTO
        Termos( gl, en, es, xenero, clase, numeros, abreviacion )
    VALUES
        ( "termo_GL_1" , "termo_EN_1" , "termo_ES_1" , "femenino"  , "adxetivo"   , "plural"   , "forma completa" ) ,
        ( "termo_GL_2" , "termo_EN_2" , "termo_ES_2" , "masculino" , "adxetivo"   , "singular" , "abreviación"    ) ,
        ( "termo_GL_3" , "termo_EN_3" , "termo_ES_3" , "femenino"  , "sustantivo" , "plural"   , "forma completa" ) ,
        ( "termo_GL_4" , "termo_EN_4" , "termo_ES_4" , "neutro"    , "adxetivo"   , "plural"   , "forma completa" ) ,
        ( "termo_GL_5" , "termo_EN_5" , "termo_ES_5" , "femenino"  , "adxetivo"   , "plural"   , "forma completa" ) ,
        ( "termo_GL_6" , "termo_EN_6" , "termo_ES_6" , "femenino"  , "verbo"      , "singular" , "siglas"         ) ,
        ( "termo_GL_7" , "termo_EN_7" , "termo_ES_7" , "neutro"    , "adxetivo"   , "plural"   , "forma completa" ) ,
        ( "termo_GL_8" , "termo_EN_8" , "termo_ES_8" , "femenino"  , "adxetivo"   , "plural"   , "forma completa" ) ,
        ( "termo_GL_9" , "termo_EN_9" , "termo_ES_9" , "masculino" , "adxetivo"   , "singular" , "forma completa" ) ;

    INSERT INTO
        AreasTematicas( id_area, area )
    VALUES
        (1, "area_1"),
        (1, "area_2"),
        (1, "area_3"),
        (2, "area_2"),
        (3, "area_2"),
        (3, "area_3"),
        (4, "area_2"),
        (5, "area_4"),
        (6, "area_4"),
        (7, "area_4"),
        (8, "area_2"),
        (9, "area_1"),
        (9, "area_2");

    INSERT INTO
        Definicions( id_definicion, definicion )
    VALUES
        (1, "definicion_1_1"),
        (1, "definicion_1_2"),
        (1, "definicion_1_3"),
        (2, "definicion_2_1"),
        (3, "definicion_3_1"),
        (4, "definicion_4_1"),
        (5, "definicion_5_1"),
        (6, "definicion_6_1"),
        (7, "definicion_7_1"),
        (8, "definicion_8_1"),
        (9, "definicion_9_1"),
        (9, "definicion_9_2"),
        (9, "definicion_9_3");

    INSERT INTO
        Fontes(id_fonte, fonte)
    VALUES
        (1, "Miña imaxinacion");

    INSERT INTO
        Sinonimos(id_sinonimo, sinonimo)
    VALUES
        (5, 6), -- Termos con id 5, 6 e 7 son sinónimos
        (5, 7);

END TRANSACTION;
