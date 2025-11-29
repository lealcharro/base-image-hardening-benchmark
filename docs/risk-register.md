# Registro de riesgos presentes 

**1. Análisis de seguridad impreciso o incompleto**
*   **Descripción:** Los programas que usamos para buscar fallos de seguridad podrían no encontrarlos todos, o podrían avisar de fallos que no son reales. Una mala configuración de estos programas también puede dar resultados poco fiables.
*   **Impacto:** Alto
*   **Plan de mitigación:** 
    *   Usar dos programas de escaneo distintos para comparar sus hallazgos.
    *   Asegurarse de que los programas estén actualizados a su última versión antes de usarlos.
    *   Revisar a mano algunos de los fallos más graves para ver si son un problema real.
    *   Anotar cómo se configuraron los programas para poder repetir el análisis igual.
*   **Estado:** Abierto 

**2. Métricas de comparación no representativas que lleven a conclusiones erróneas.**
*   **Descripción:** Las cosas que medimos (tamaño, número de fallos) podrían no contar toda la historia. Una imagen puede parecer segura por tener pocos fallos, pero tener uno muy grave, mientras que otra con muchos fallos pequeños es en realidad más segura.
*   **Impacto:** Medio
*   **Plan de mitigación:**
    *   Tener en cuenta qué tan graves son los fallos encontrados, no solo cuántos hay.
    *   Añadir un comentario en el informe final explicando qué significan los números.
    *   Dejar claro en el informe qué cosas no se midieron.
*   **Estado:** Cerrado

**3. Entorno de construcción inconsistente que invalide la comparación de métricas.**
*   **Descripción:** Si cada vez que creamos las imágenes lo hacemos de una forma un poco diferente (distinto ordenador, distinto día), los resultados pueden variar. Esto haría que la comparación del tamaño o los fallos no sea justa.
*   **Impacto:** Alto
*   **Plan de mitigación:**
    *   Usar siempre el mismo sistema automático para crear las imágenes.
    *   Especificar versiones exactas de los componentes que usamos (ej. `ubuntu:22.04` en vez de `ubuntu:latest`).
    *   Realizar todas las pruebas y análisis de una sola vez para que nada cambie entre medias.
*   **Estado:** Cerrado

**4. Exceso de enfoque en una sola métrica (ej. tamaño) ignorando el balance con seguridad.**
*   **Descripción:** Es fácil obsesionarse con un solo dato, como que la imagen sea muy pequeña, y olvidarse de otras cosas importantes. Una imagen pequeña podría ser insegura o muy difícil de usar si algo falla.
*   **Impacto:** Medio
*   **Plan de mitigación:**
    *   Crear una tabla de puntuación que valore varios aspectos (seguridad, tamaño, facilidad de uso) para decidir qué imagen es mejor.
    *   Usar gráficos para que se entiendan fácilmente las ventajas y desventajas de cada una.
    *   Recordar en el informe final que la mejor elección es un balance de todos los factores.
*   **Estado:** Abierto

**5. Interpretación incorrecta de los permisos necesarios, resultando en una aplicación no funcional o insegura.**
*   **Descripción:** Es complicado saber qué "permisos especiales" necesita la aplicación para funcionar. Si le quitamos permisos que necesita, la aplicación se romperá. Si le dejamos permisos peligrosos que no usa, la hacemos más insegura.
*   **Impacto:** Medio
*   **Plan de mitigación:**
    *   Investigar qué "permisos especiales" necesita realmente la aplicación.
    *   Añadir capas extra de seguridad para limitar aún más lo que puede hacer la aplicación.
    *   Comprobar que la aplicación sigue funcionando correctamente después de quitarle permisos.
*   **Estado:** Abierto
