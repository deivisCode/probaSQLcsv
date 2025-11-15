SHELL := bash
.PHONY: limpa

datos.db: termos.csv ordes.sql
	sqlite3 datos.db -- '.read ordes.sql'
	sqlite3 datos.db -- '.import --csv --skip 1 termos.csv Termos'

limpa:
	rm datos.db
