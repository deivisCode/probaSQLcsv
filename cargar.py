import pandas as pd
import sqlite3

ordes: str = "ordes.sql"

class conexionAberta:
    """Un Contexto que me permite abrir e pechar unha
    conexión cunha base de datos de SQLite3"""

    def __init__(self, ruta: str ):
        self.ruta = ruta
        self.conexion: sqlite3.Connection = sqlite3.connect(self.ruta)
        print(f"\nCreado obxeto Conexion(...): {self.conexion}")

    def __enter__(self):
        return self.conexion

    def __exit__(self, exc_type, exc_value, exc_traceback):
        self.conexion.close()
        print("Pechada a conexión\n")

with open(ordes, "r") as o:
    with conexionAberta("datos.db") as c:
        c.executescript(o.read())
        print(f"Executadas as ordes de SQL: {ordes}")

termos = pd.read_csv(
    "datos/termos.csv",
    sep       = ',',
    header    = 0,
    index_col = 0
)

print(termos)
