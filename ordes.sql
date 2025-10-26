PRAGMA foreign_keys = ON;

BEGIN TRANSACTION;

    CREATE TABLE IF NOT EXISTS Termos(
        id_termos INTEGER PRIMARY KEY AUTOINCREMENT,
        gl TEXT NOT NULL UNIQUE,
        en TEXT NOT NULL,
        es TEXT NOT NULL,
        area_tematica_1 TEXT NOT NULL,
        area_tematica_2 TEXT NOT NULL,
        area_tematica_3 TEXT NOT NULL,
        areas TEXT GENERATE ALWAYS AS ( concat_ws (' > ',area_tematica_1,area_tematica_2,area_tematica_3)) STORED,
        xenero TEXT NOT NULL CHECK (xenero in ('femenino', 'masculino', 'neutro') ),
        clase TEXT NOT NULL CHECK (clase in ('sustantivo', 'verbo', 'adxetivo')),
        numeros TEXT NOT NULL CHECK (numeros in ('singular', 'plural')),
        abreviacion TEXT NOT NULL CHECK (abreviacion in ('forma completa', 'siglas', 'abreviacion')),
        fontes TEXT NOT NULL,
        -- https://sqlite.org/datatype3.html
        -- https://sqlite.org/lang_datefunc.html
        -- data_inclusion
        -- data_modificacion
        FOREIGN KEY (xenero) REFERENCES Denominacions (proba)
    );

END TRANSACTION;


BEGIN TRANSACTION;

    CREATE TABLE IF NOT EXISTS Denominacions(
        id_denominacions INTEGER PRIMARY KEY AUTOINCREMENT,
        proba TEXT
    );

END TRANSACTION;

BEGIN TRANSACTION;
    INSERT INTO Denominacions(proba) VALUES ('femenino', 'masculino', 'neutro');
END TRANSACTION;
