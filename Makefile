SHELL := bash
.DEFAULT_GOAL := datos.db
.PHONY: limpa

DATOS := $(wildcard datos/*.csv)

datos.db: $(DATOS) ordes.sql
	python3 cargar.py

limpa: datos.db
	rm datos.db
