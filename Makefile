.PHONY: help build inspect clean run test

# Variables
IMAGE_NAME ?= base-image-hardening-benchmark
TAG ?= latest
CONTAINER_NAME ?= benchmark-app
PORT ?= 5000

help: ## Muestra esta ayuda
	@echo "Comandos disponibles:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

build: ## Construye la imagen Docker
	@echo "Construyendo imagen $(IMAGE_NAME):$(TAG)..."
	@echo "TODO: Implementar construcción de las 3 variantes (ubuntu, slim, alpine)"
	@echo "Por ahora, este target está pendiente hasta que los Dockerfiles sean completados"

inspect: ## Inspecciona la imagen Docker construida
	@echo "Inspeccionando imagen $(IMAGE_NAME):$(TAG)..."
	@echo "TODO: Delegar a scripts/inspect-images.sh cuando esté implementado"
	@docker image inspect $(IMAGE_NAME):$(TAG) 2>/dev/null || echo "Error: Imagen no encontrada. Ejecuta 'make build' primero."

clean: ## Limpia contenedores, imágenes y reportes generados
	@echo "Limpiando recursos..."
	@docker stop $(CONTAINER_NAME) 2>/dev/null || true
	@docker rm $(CONTAINER_NAME) 2>/dev/null || true
	@docker rmi $(IMAGE_NAME):$(TAG) 2>/dev/null || true
	@rm -rf reports/*.json reports/*.html 2>/dev/null || true
	@echo "Limpieza completada."

run: build ## Construye y ejecuta el contenedor
	@echo "Ejecutando contenedor $(CONTAINER_NAME)..."
	@echo "TODO: Implementar cuando el Dockerfile esté completo"

test: ## Ejecuta pruebas básicas de los endpoints
	@echo "Probando endpoint /..."
	@curl -s http://localhost:$(PORT)/ | jq '.' || echo "Error: Asegúrate de que el contenedor esté corriendo (make run)"
	@echo "\nProbando endpoint /health..."
	@curl -s http://localhost:$(PORT)/health | jq '.' || echo "Error: Asegúrate de que el contenedor esté corriendo (make run)"
