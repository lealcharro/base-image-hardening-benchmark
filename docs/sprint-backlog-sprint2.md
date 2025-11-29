### Issue #5: Script cap-check.sh y perfil seccomp

| Campo | Valor |
|-------|-------|
| **ID** | BIHB-005 |
| **Sprint** | 2 |
| **Prioridad** | Alta |
| **Responsable** |Aaron|

**Descripción:**  
Script para verificar capabilities de los contenedores y archivo de perfil seccomp básico.

**Criterios de aceptación:**
- [ ] `scripts/cap-check.sh` ejecuta cada variante y lista capabilities activas
- [ ] `docker/seccomp-profile.json` con perfil restrictivo básico
- [ ] Prueba al menos una imagen con `--security-opt seccomp=...`
- [ ] Muestra comparación de capabilities entre variantes

---

### Issue #6: Script generate_report.py

| Campo | Valor |
|-------|-------|
| **ID** | BIHB-006 |
| **Sprint** | 2 |
| **Prioridad** | Alta |
| **Responsable** | Diego |

**Descripción:**  
Script Python que agrega todos los datos y genera el reporte benchmark.json.

**Criterios de aceptación:**
- [ ] Lee datos de tamaño, capas y capabilities de cada imagen
- [ ] Genera `reports/benchmark.json` con estructura clara
- [ ] Incluye timestamp del análisis
- [ ] Incluye resumen comparativo
- [ ] Target `make report` agregado al Makefile

---

### Issue #7: Targets scan/sbom y validación final

| Campo | Valor |
|-------|-------|
| **ID** | BIHB-007 |
| **Sprint** | 2 |
| **Prioridad** | Media |
| **Responsable** | Leonardo |

**Descripción:**  
Agregar targets de seguridad al Makefile y validar funcionamiento completo del proyecto.

**Criterios de aceptación:**
- [ ] `make scan` - ejecuta análisis de seguridad (real con trivy o simulado)
- [ ] `make sbom` - genera SBOM (real con syft o simulado)
- [ ] Resultados guardados en `reports/`
- [ ] `README.md` actualizado con instrucciones completas de uso
- [ ] Todos los comandos `make` funcionan sin errores
- [ ] Proyecto reproducible (clonar -> make build -> make report)

---

### Issue #8: Documentación completa

| Campo | Valor |
|-------|-------|
| **ID** | BIHB-008 |
| **Sprint** | 2 |
| **Prioridad** | Media |
| **Responsable** | Leonardo |

**Descripción:**  
Completar todos los archivos de documentación requeridos en la carpeta docs/.

**Criterios de aceptación:**
- [ ] `docs/vision.md` - contexto, problema, alcance, objetivos
- [ ] `docs/sprint-backlog-sprint1.md` - historias y tareas del sprint 1
- [ ] `docs/sprint-backlog-sprint2.md` - historias y tareas del sprint 2
- [ ] `docs/definition-of-done.md` - criterios para marcar tareas como Done
- [ ] `docs/risk-register.md` - mínimo 5 riesgos con probabilidad/impacto/mitigación
- [ ] `docs/metrics.md` - métricas de ambos sprints

---

