import pandas as pd
import sqlite3
import pathlib
import sys

# Creo un contexto para usar con 'with' despois
class conexionAberta:
    """Un Contexto que me permite abrir e pechar unha
    conexión cunha base de datos de SQLite3"""

    # método que se usa ao crear o obxeto
    def __init__(self, ruta ):
        self.ruta = ruta
        self.conexion = sqlite3.connect(self.ruta)
        print(f"Creado obxeto Conexion(...): {self.conexion}")

    # método que se usa para devolver o contido (with ... AS f)
    def __enter__(self):
        return self.conexion

    # método que se executa ao rematar o with
    def __exit__(self, exc_type, exc_value, exc_traceback):
        self.conexion.close()
        print("Pechada a conexión")

# Esto é pa logo buscar os datos no diretorio que sexa
arquivo_ordes               = "ordes.sql"
DIRETORIO_PRINCIPAL = str(pathlib.Path(__file__).parent.resolve())
DIRETORIO_DATOS     = DIRETORIO_PRINCIPAL + "/datos/"
NOMES_TABOAS        = ["AreasTematicas", "Definicions", "Fontes", "Termos"]
RUTAS_TABOAS        = [ DIRETORIO_DATOS + nome + ".csv" for nome in NOMES_TABOAS ]

print(f"FICHEIRO_DE_ORDES: {arquivo_ordes}")
print(f"DIRETORIO_PRINCIPAL: {DIRETORIO_PRINCIPAL}")
print(f"DIRETORIO_DATOS: {DIRETORIO_DATOS}")

for nome, ruta in zip(NOMES_TABOAS, RUTAS_TABOAS):
    print(f"RUTA_{nome}: {ruta}")

# Vou facer unha lista con varios DataFrames
DATOS = []
for ruta,nome in zip(RUTAS_TABOAS,NOMES_TABOAS):
    try:
        df = pd.read_csv(
            ruta,
            sep=",",
            header=0,
            # index_col=0
        )
    except Exception as erro:
        print(f"Os datos de {ruta} non se puideron cargar en Pandas ")
        print(f"Erro de tipo {erro}")
        sys.exit()

    DATOS.append(df)

del(df)

# Mostro información variada das táboas CSV para comprobar que todo vai ben
for nome, df in zip(NOMES_TABOAS,DATOS):
    print(f"DF_{nome}: {df.shape[0]}x{df.shape[1]} {list(df.columns)}")
    # print(df)

# Gardo as ordes de SQL nunha variable para despois
with open(arquivo_ordes, "r") as o:

    # Leo as ordes
    ordes = o.read()
    print("Lidas as ordes de SQL")

# Uso o contexto que creei ao comezo
with conexionAberta("datos.db") as conexion:

    # Executo as ordes de SQL
    conexion.executescript(ordes)
    print(f"Executadas as ordes de SQL")

    print("\nINI\n")

    # non sei como meter os valores na base de datos...
    for nome, df in zip(NOMES_TABOAS, DATOS):

        columnas = ", ".join(df.columns)
        print(columnas)

    print("\nFIN\n")
