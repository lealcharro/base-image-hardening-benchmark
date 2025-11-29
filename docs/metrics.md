# Métricas - Base Image Hardening Benchmark

Registro de métricas por sprint.

---

## Sprint 1

**Período:** Nov 27, 2025 - Nov 27, 2025
**Meta del Sprint:** Construcción base del proyecto (Dockerfiles, scripts, CI/CD)

### 1. Throughput

| Métrica | Valor |
|---------|-------|
| Historias Completadas | 3 |
| Tareas No Completadas | 0 |

**Historias:** #2 Configuración inicial, #1 Script build-all.sh, #7 Creación de Dockerfiles

---

### 2. Lead Time

| Historia | ID | Fecha In Progress | Fecha Done | Lead Time |
|----------|----|--------------------|------------|-----------|
| Configuración inicial | #2 | Nov 27, 2025 | Nov 27, 2025 | 4 |
| Script build-all.sh | #1 | Nov 27, 2025 | Nov 27, 2025 | 4 |
| Creación Dockerfiles | #7 | Nov 27, 2025 | Nov 27, 2025 | 4 |

**Lead Time Promedio:** 4

---

### 3. WIP (Máximo Acordado: 3)

| Período | Máximo Observado | Estado |
|---------|------------------|--------|
| Nov 27, 2025 - Nov 27, 2025 | 2 | Ok |

---

### 4. Builds

| Workflow | Exitosos | Fallidos | Tasa de Éxito |
|----------|----------|----------|---------------|
| ci.yml | 37 | 0 | 100 ½ |
| security-scan.yml | 37 | 0 | 100 ½ |

**Comando:** `gh run list --workflow=ci.yml --limit 100 --json conclusion`

---

### 5. Vulnerabilidades Detectadas

| Variante | CRITICAL | HIGH | MEDIUM | LOW | Total |
|----------|----------|------|--------|-----|-------|
| ubuntu | 0| 0 | 0 | 0 | 0 |
| slim | 0 | 0 | 0 | 0 | 0 |
| alpine | 0 | 0 | 0 | 0 | 0 |

**Comando:** `make scan` → analizar JSON en `reports/security-scan-*.json`

---

### 6. Vulnerabilidades Mitigadas

| CVE | Variante | Severidad | Mitigación | Fecha |
|-----|----------|-----------|-----------|-------|
| N/A | - | - | - | - |

---

---

## Sprint 2

**Período:** Nov 28, 2025 - Nov 28, 2025
**Meta del Sprint:** Análisis de seguridad avanzado (capabilities, seccomp, SBOM, reportes)

### 1. Throughput

| Métrica | Valor |
|---------|-------|
| Historias Completadas | 3 |
| Tareas No Completadas | 0 |

**Historias:** #13 Script check-cap.sh, #11 Script generate_report, #10 Targets scan/sbom

---

### 2. Lead Time

| Historia | ID | Fecha In Progress | Fecha Done | Lead Time |
|----------|----|--------------------|------------|-----------|
| Script check-cap.sh y seccomp | #13 | Nov 28, 2025 | Nov 28, 2025 | 4 |
| Script generate_report | #11 | Nov 28, 2025 | Nov 28, 2025 | 6 |
| Targets scan/sbom y validación | #10 | Nov 28, 2025 | Nov 28, 2025 | 10 |

**Lead Time Promedio:** 6

---

### 3. WIP (Máximo Acordado: 3)

| Período | Máximo Observado | Estado |
|---------|------------------|--------|
| Nov 28, 2025 - Nov 28, 2025 | 2 | Ok |

---

### 4. Builds

| Workflow | Exitosos | Fallidos | Tasa de Éxito |
|----------|----------|----------|---------------|
| ci.yml | 37 | 0 | 100½ |
| security-scan.yml | 37 | 0 | 100½ |

**Comando:** `gh run list --workflow=ci.yml --limit 100 --json conclusion`

---

### 5. Vulnerabilidades Detectadas

| Variante | CRITICAL | HIGH | MEDIUM | LOW | Total |
|----------|----------|------|--------|-----|-------|
| ubuntu | 0| 0 | 0 | 0 | 0 |
| slim | 0 | 0 | 0 | 0 | 0 |
| alpine | 0 | 0 | 0 | 0 | 0 |

**Comando:** `make scan` → analizar JSON en `reports/security-scan-*.json`

---

### 6. Vulnerabilidades Mitigadas

| CVE | Variante | Severidad | Mitigación | Fecha |
|-----|----------|-----------|-----------|-------|
| N/A | - | - | - | - |

---

**Última actualización:** 29 nov, 2025
