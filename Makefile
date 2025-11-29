.PHONY: help build inspect clean run test

# Variables
IMAGE_NAME ?= base-image-hardening-benchmark
TAG ?= latest
CONTAINER_NAME ?= benchmark-app
PORT ?= 8080
VARIANT ?= alpine
GIT_SHA ?= $(shell git rev-parse --short HEAD)

help: ## Muestra esta ayuda
	@echo "Comandos disponibles:"
	@echo "  build           Construye las 3 variantes de imágenes Docker (ubuntu, slim, alpine)"
	@echo "  inspect         Inspecciona y compara las 3 variantes de imágenes Docker"
	@echo "  clean           Limpia contenedores, imágenes y reportes generados"
	@echo "  run             Construye y ejecuta el contenedor (usa VARIANT=ubuntu|slim|alpine)"
	@echo "  test            Ejecuta pruebas básicas de los endpoints"
	@echo "  check-cap       Permite obtener las capabilities de cada una de las imágenes"
	@echo "  report          Genera el reporte de benchmark en formato JSON"

build: ## Construye las 3 variantes de imágenes Docker (ubuntu, slim, alpine)
	@echo "Construyendo las 3 variantes de imágenes..."
	@./scripts/build-all.sh

inspect: ## Inspecciona y compara las 3 variantes de imágenes Docker
	@./scripts/inspect-images.sh

clean: ## Limpia contenedores, imágenes y reportes generados
	@echo "Limpiando recursos..."
	@docker stop $(CONTAINER_NAME) 2>/dev/null || true
	@docker rm $(CONTAINER_NAME) 2>/dev/null || true
	@docker rmi app-ubuntu:$(GIT_SHA) 2>/dev/null || true
	@docker rmi app-slim:$(GIT_SHA) 2>/dev/null || true
	@docker rmi app-alpine:$(GIT_SHA) 2>/dev/null || true
	@rm -rf reports/*.json 2>/dev/null || true
	@echo "Limpieza completada."

run: build ## Construye y ejecuta el contenedor (usa VARIANT=ubuntu|slim|alpine)
	@echo "Ejecutando contenedor $(CONTAINER_NAME) con variante $(VARIANT)..."
	@docker stop $(CONTAINER_NAME) 2>/dev/null || true
	@docker rm $(CONTAINER_NAME) 2>/dev/null || true
	@docker run -d --name $(CONTAINER_NAME) -p $(PORT):8080 app-$(VARIANT):$(GIT_SHA)
	@echo "Contenedor ejecutándose en http://localhost:$(PORT)"

test: ## Ejecuta pruebas básicas de los endpoints
	@echo "Probando endpoint /..."
	@curl -s http://localhost:$(PORT)/ | jq '.' || echo "Error: Asegúrate de que el contenedor esté corriendo (make run)"
	@echo "\nProbando endpoint /health..."
	@curl -s http://localhost:$(PORT)/health | jq '.' || echo "Error: Asegúrate de que el contenedor esté corriendo (make run)"

check-cap: ## Permite obtener las capabilities de cada una de las imágenes
	@echo "Obteniendo capabilities de las imágenes..."
	@./scripts/cap-check.sh

report: build ## Genera el reporte de benchmark en formato JSON
	@echo "Generando reporte de benchmark..."
	@python3 tools/generate_report.py
