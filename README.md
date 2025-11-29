# Benchmark de Hardening de Imágenes Base

## Descripción

Este proyecto es un benchmark de hardening para comparar imágenes base de Docker (`Ubuntu`, `Python Slim` y `Alpine`). La idea es empaquetar una misma aplicación web escrita en Python y Flask en estas tres variantes de imágenes para luego analizar y comparar sus pros y contras en términos de seguridad, tamaño y rendimiento.

## Sprint 1 - Alcance

El objetivo de este primer sprint fue construir la base del proyecto, lo que incluyó:

- **Creación de los 3 Dockerfiles**: `Dockerfile.ubuntu`, `Dockerfile.slim` y `Dockerfile.alpine`.
- **Implementación de un usuario no-root**: Para todas las imágenes, como primera medida de hardening.
- **Builds multi-stage**: Para las variantes `slim` y `alpine`, buscando optimizar el tamaño final de la imagen.
- **Script de build**: Un script en Bash (`scripts/build-all.sh`) que automatiza la construcción de las 3 imágenes y las etiqueta con el hash del commit de Git para trazabilidad.
- **Script de inspección**: Un script (`scripts/inspect-images.sh`) para comparar características básicas de las imágenes generadas, como tamaño y número de capas.
- **Makefile**: Para la automatización de tareas comunes como la construcción, ejecución, inspección y limpieza del proyecto.
- **Flujos de trabajo de GitHub Actions**: Implementación de `ci.yml` para integración continua y `security-scan.yml` para escaneo de seguridad.

## Objetivos

- **Comparar el tamaño** de las imágenes Docker resultantes para cada variante.
- **Analizar la superficie de ataque**, entendiendo qué binarios y librerías innecesarias se pueden eliminar.
- **Medir el rendimiento** de la aplicación en cada una de las imágenes base.
- **Establecer una línea base** para futuras optimizaciones de seguridad (hardening).

## Arquitectura

El proyecto está compuesto por:

1.  **Aplicación Web (`app/`)**: Una aplicación simple en Flask con dos endpoints: `/` (info básica) y `/health` (healthcheck).
2.  **Dockerfiles (`docker/`)**:
    - `Dockerfile.ubuntu`: Usa `ubuntu:22.04` y sigue un enfoque de una sola etapa.
    - `Dockerfile.slim`: Usa `python:3.12-slim` con un build multi-stage para reducir el tamaño.
    - `Dockerfile.alpine`: Usa `python:3.12-alpine`, también con build multi-stage y siendo la imagen más ligera.
3.  **Scripts (`scripts/`)**:
    - `build-all.sh`: Para construir todas las imágenes.
    - `inspect-images.sh`: Para analizar las imágenes construidas.
4.  **Makefile**: Centraliza los comandos para la gestión del proyecto.
5.  **GitHub Actions (`.github/workflows/`)**:
    - `ci.yml`: Configuración de integración continua.
    - `security-scan.yml`: Configuración para escaneos de seguridad automatizados.

## Cómo Correr

Para correr el proyecto se puede usar los comandos definidos en el `Makefile`.

### 1. Construir las imágenes

Este comando invoca el script `build-all.sh` y crea las tres variantes de la imagen (`app-ubuntu`, `app-slim`, `app-alpine`), cada una con el hash del commit actual como tag.

```bash
make build
```

### 2. Inspeccionar las imágenes

Una vez construidas, se puede usar este comando para ver una comparación de su tamaño, número de capas y el usuario con el que corren.

```bash
make inspect
```

### 3. Ejecutar un contenedor

Se puede levantar un contenedor con la variante de imagen que se prefiera. Por defecto, usa `alpine`.

```bash
# Para correr con Alpine (default)
make run

# Para correr con Ubuntu
make run VARIANT=ubuntu

# Para correr con Slim
make run VARIANT=slim
```

El contenedor estará disponible en `http://localhost:8080`.

### 4. Probar los endpoints

Con el contenedor en ejecución, se pueden probar los endpoints de la aplicación:

```bash
make test
```

### 5. Análisis de Seguridad

Se puede ejecutar un análisis de seguridad automático en las imágenes generadas usando Trivy:

```bash
make scan
```

Este comando:
- Construye las imágenes (si no existen)
- Ejecuta un escaneo de seguridad en cada variante
- Genera reportes JSON en la carpeta `reports/`
- Soporta tanto Trivy instalado localmente como en Docker

**Nota:** Si Trivy no está disponible, se genera un reporte simulado con fines de demostración.

### 6. Generar Software Bill of Materials (SBOM)

Se puede generar un SBOM para cada variante de imagen usando Syft:

```bash
make sbom
```

Este comando:
- Construye las imágenes (si no existen)
- Genera SBOM en formato JSON y SPDX para cada variante
- Almacena los reportes en `reports/`
- Soporta tanto Syft instalado localmente como en Docker

**Nota:** Si Syft no está disponible, se genera un SBOM simulado con fines de demostración.

### 7. Generar Reportes Completos

Para ejecutar ambos análisis (seguridad y SBOM) en un solo comando:

```bash
make report
```

Este comando ejecuta `make scan` y `make sbom` en secuencia, generando un conjunto completo de reportes de seguridad y composición de software.

### 8. Limpiar

Para detener y eliminar los contenedores e imágenes generadas por el proyecto, se ejecuta:

```bash
make clean
```

## Reproducibilidad

El proyecto está diseñado para ser completamente reproducible. Para reproducir el flujo completo desde cero:

```bash
# 1. Clonar el repositorio
git clone <repository-url>
cd base-image-hardening-benchmark
# 2. Construir las imágenes
make build
# 3. Inspeccionar las imágenes
make inspect
# 4. Generar reportes de seguridad y SBOM
make report
# 5. Ver resultados
ls -lh reports/
cat reports/security-scan-*.json | jq .
cat reports/sbom-*.json | jq .
# 6. Ejecutar y probar (opcional)
make run VARIANT=alpine
make test
make clean
```

**Ventajas de esta estructura:**
- Cada paso es independiente y reutilizable
- Los reportes se almacenan con timestamp para histórico
- Compatible con CI/CD (GitHub Actions)
- No requiere dependencias adicionales (soporta ejecución vía Docker)
- Facilita la auditoría y comparación de seguridad entre variantes

## Videos

- **Sprint 1**: https://drive.google.com/file/d/10CcC4_fwJP4LmTd209WLs2K8jIEm2BsA/view?usp=sharing
- **Sprint 2**: https://drive.google.com/file/d/1PU_OdjN8W-Qm7RBWQ36181TF7R7M2BT0/view?usp=sharing
