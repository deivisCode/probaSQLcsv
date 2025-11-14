PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Definicions ;
DROP TABLE IF EXISTS Termos ;

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

    INSERT INTO
        Termos( gl, en, es, xenero, clase, numeros, abreviacion )
    VALUES
        ( "termo_gl_1", "termo_en_1", "termo_es_1", "femenino", "adxetivo", "plural", "forma completa"),
        ( "termo_gl_2", "termo_en_2", "termo_es_2", "femenino", "adxetivo", "plural", "forma completa"),
        ( "termo_gl_3", "termo_en_3", "termo_es_3", "femenino", "adxetivo", "plural", "forma completa");

    INSERT INTO
        AreasTematicas( id_area, area )
    VALUES
        (1, "area_1"),
        (1, "area_2"),
        (1, "area_3"),
        (2, "area_2");

    INSERT INTO
        Definicions( id_definicion, definicion )
    VALUES
        (1, "definicion_1_1"),
        (1, "definicion_1_2"),
        (1, "definicion_1_3"),
        (2, "definicion_2_1"),
        (3, "definicion_1_1");

    INSERT INTO
        Fontes(id_fonte, fonte)
    VALUES
        (1, "Miña imaxinacion");

END TRANSACTION;
