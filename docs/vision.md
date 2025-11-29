# Documento de visión

## Contexto:
Un equipo de plataforma quiere demostrar con datos qué tan diferente es usar ubuntu, python:3.12-slim y alpine/distroless en términos de tamaño, superficie de ataque y capacidades (permisos de usuarios asignados dadas las imágenes).

## Problema que resuelve:
La elección de una imagen base de contenedor a menudo se basa en la familiaridad o en recomendaciones generales, sin un análisis cuantitativo de las compensaciones. Esto puede llevar al uso de imágenes más grandes y con más vulnerabilidades de las necesarias, aumentando la superficie de ataque y los riesgos de seguridad. Este proyecto aborda la falta de datos comparativos claros para tomar decisiones informadas sobre qué imagen base utilizar.

## Alcance:
El proyecto se centrará en:
1.  Construir una aplicación Python simple sobre tres imágenes base diferentes: `ubuntu`, `python:3.12-slim` y `alpine`.
2.  Medir y comparar las siguientes métricas para cada imagen:
    *   Tamaño final de la imagen.
    *   Superficie de ataque (número de paquetes y vulnerabilidades detectadas).
    *   Capacidades de Linux por defecto.
    *   Usuario y permisos con los que se ejecuta la aplicación.
3.  Automatizar la construcción, el escaneo y la generación de reportes a través de scripts y CI/CD.
4.  El análisis no incluirá la optimización del código de la aplicación, sino que se centrará exclusivamente en las características de las imágenes base.

## Objetivos técnicos y de aprendizaje:
*   **Técnicos:**
    *   Crear un flujo de trabajo automatizado para construir y analizar las imágenes de Docker.
    *   Integrar herramientas de escaneo de vulnerabilidades (como Trivy o Grype) en el proceso.
    *   Generar un informe comparativo con las métricas recopiladas.
    *   Implementar buenas prácticas de hardening de imágenes (perfiles seccomp).
*   **De aprendizaje:**
    *   Comprender el impacto real de la elección de la imagen base en la seguridad y el rendimiento.
    *   Cuantificar la superficie de ataque y entender los vectores de riesgo en contenedores.
    *   Aprender a utilizar herramientas de análisis de seguridad de contenedores.
    *   Evaluar cómo las diferentes distribuciones de Linux gestionan la seguridad y los permisos por defecto en un entorno de contenedores.
