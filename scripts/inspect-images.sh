#!/usr/bin/env bash

set -euo pipefail

# Obtener git sha para identificar las imagenes
GIT_SHA=$(git rev-parse --short HEAD)

# Variantes de imagenes a inspeccionar
VARIANTS=("ubuntu" "slim" "alpine")

# Encabezado para el formato parseable
echo "variant size_mb layers user"

# Inspeccionar cada variante
for VARIANT in "${VARIANTS[@]}"; do
    IMAGE_NAME="app-${VARIANT}:${GIT_SHA}"

    if ! docker image inspect "${IMAGE_NAME}" &> /dev/null; then
        echo "${VARIANT} null null null"
        continue
    fi

    # Obtener el tamaño en MB
    size_bytes=$(docker image inspect "${IMAGE_NAME}" --format='{{.Size}}')
    size_mb=$(awk -v size="$size_bytes" 'BEGIN { printf "%.2f", size / 1024 / 1024 }')

    # Obtener el numero de capas
    layer_count=$(docker image inspect "${IMAGE_NAME}" --format='{{len .RootFS.Layers}}')

    # Obtener el usuario por defecto
    user=$(docker image inspect "${IMAGE_NAME}" --format='{{.Config.User}}')
    if [ -z "$user" ]; then
        user="root"
    fi

    echo "${VARIANT} ${size_mb} ${layer_count} ${user}"
done
