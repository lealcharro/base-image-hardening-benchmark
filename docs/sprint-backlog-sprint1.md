### Issue #1: Configuración inicial y app Python

| Campo | Valor |
|-------|-------|
| **ID** | BIHB-001 |
| **Sprint** | 1 |
| **Prioridad** | Alta |
| **Responsable** | Leonardo |

**Descripción:**  
Crear estructura del proyecto y la aplicación Flask básica.

**Criterios de aceptación:**
- [ ] Estructura de carpetas creada: `app/`, `docker/`, `scripts/`, `reports/`, `docs/`
- [ ] `app/main.py` con endpoints `/` y `/health`
- [ ] `app/requirements.txt` con flask
- [ ] `.gitignore` y `.dockerignore` configurados
- [ ] Makefile con targets: `build`, `inspect`, `clean`

---

### Issue #2: Crear Dockerfiles

| Campo | Valor |
|-------|-------|
| **ID** | BIHB-002 |
| **Sprint** | 1 |
| **Prioridad** | Alta |
| **Responsable** | Aaron |

**Descripción:**  
Crear Dockerfile.slim y Dockerfile.alpine para empaquetar la misma app.

**Criterios de aceptación:**
- [ ] `docker/Dockerfile.slim` con base `python:3.12-slim` (multi-stage)
- [ ] `docker/Dockerfile.alpine` con base `python:3.12-alpine` (multi-stage)
- [ ] Todos configurados con USER no root
- [ ] Tags fijos en todas las imágenes base (no usar `latest`)

---

### Issue #3: Script build-all.sh

| Campo | Valor |
|-------|-------|
| **ID** | BIHB-003 |
| **Sprint** | 1 |
| **Prioridad** | Alta |
| **Responsable** | Diego |

**Descripción:**  
Implementacion imagen Dockerfile.ubuntu y script Bash para construir las 3 variantes de imagen Docker.

**Criterios de aceptación:**
- [ ] `docker/Dockerfile.ubuntu` con base `ubuntu:22.04` configurado con USER no root
- [ ] Construye imágenes: `app-ubuntu`, `app-slim`, `app-alpine`
- [ ] Tags con git sha corto (ej: `app-slim:abc1234`)
- [ ] Primera línea: `#!/usr/bin/env bash`
- [ ] Incluye `set -euo pipefail`

---

### Issue #4: Script inspect-images.sh y Makefile

| Campo | Valor |
|-------|-------|
| **ID** | BIHB-004 |
| **Sprint** | 1 |
| **Prioridad** | Media |
| **Responsable** | Leonardo |

**Descripción:**  
Script para inspeccionar las imágenes construidas y Makefile del proyecto.

**Criterios de aceptación:**
- [ ] `scripts/inspect-images.sh` muestra: tamaño, número de capas, usuario por defecto
- [ ] Salida clara comparando las 3 variantes
- [ ] Makefile con targets: `build`, `inspect`, `clean`
---