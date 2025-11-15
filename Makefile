SHELL := bash
.DEFAULT_GOAL := datos.db
.PHONY: limpa


datos.db: datos/termos.csv ordes.sql
	sqlite3 datos.db -- '.read ordes.sql'
	sqlite3 datos.db -- '.import --csv --skip 1 datos/termos.csv Termos'

limpa:
	rm datos.db
