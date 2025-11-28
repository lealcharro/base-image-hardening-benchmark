#!/usr/bin/env bash

set -euo pipefail

# Script para inspeccionar y comparar las imagenes Docker generadas
# Muestra: tamaño, numero de capas y usuario por defecto de cada variante

# Obtener git sha para identificar las imagenes
GIT_SHA=$(git rev-parse --short HEAD)

# Variantes de imagenes a inspeccionar
VARIANTS=("ubuntu" "slim" "alpine")

# Colores para mejor visualizacion
YELLOW='\033[1;33m'
NC='\033[0m' # Sin color

echo ""
echo "  INSPECCION DE IMAGENES DOCKER"
echo "  Version: ${GIT_SHA}"
echo ""

# Funcion para obtener el tamaño de la imagen
get_image_size() {
    local image=$1
    docker image inspect "${image}" --format='{{.Size}}' 2>/dev/null | awk '{printf "%.2f MB", $1/1024/1024}'
}

# Funcion para obtener el numero de capas
get_layer_count() {
    local image=$1
    docker image inspect "${image}" --format='{{len .RootFS.Layers}}' 2>/dev/null
}

# Funcion para obtener el usuario por defecto
get_default_user() {
    local image=$1
    local user=$(docker image inspect "${image}" --format='{{.Config.User}}' 2>/dev/null)
    if [ -z "$user" ]; then
        echo "root"
    else
        echo "$user"
    fi
}


# Arreglo para almacenar datos de comparacion
declare -A sizes
declare -A layers
declare -A users

# Inspeccionar cada variante
for VARIANT in "${VARIANTS[@]}"; do
    IMAGE_NAME="app-${VARIANT}:${GIT_SHA}"

    # Verificar si la imagen existe
    if ! docker image inspect "${IMAGE_NAME}" &> /dev/null; then
        printf "${YELLOW}%-15s %-20s %-15s %-15s${NC}\n" "${VARIANT}" "NO ENCONTRADA" "-" "-"
        continue
    fi

    # Obtener informacion de la imagen
    size=$(get_image_size "${IMAGE_NAME}")
    layer_count=$(get_layer_count "${IMAGE_NAME}")
    user=$(get_default_user "${IMAGE_NAME}")

    # Guardar datos para comparacion
    sizes[$VARIANT]=$size
    layers[$VARIANT]=$layer_count
    users[$VARIANT]=$user

done

# Comparacion de tamaños
if [ ${#sizes[@]} -gt 1 ]; then
    echo "1.- TAMAÑO:"
    for VARIANT in "${VARIANTS[@]}"; do
        if [ -n "${sizes[$VARIANT]:-}" ]; then
            echo "   ${VARIANT}: ${sizes[$VARIANT]}"
        fi
    done
    echo ""
fi

# Comparacion de capas
if [ ${#layers[@]} -gt 1 ]; then
    echo "2.- CAPAS:"
    for VARIANT in "${VARIANTS[@]}"; do
        if [ -n "${layers[$VARIANT]:-}" ]; then
            echo "   ${VARIANT}: ${layers[$VARIANT]} capas"
        fi
    done
    echo ""
fi

# Comparacion de usuarios
if [ ${#users[@]} -gt 1 ]; then
    echo "3.- USUARIO POR DEFECTO:"
    for VARIANT in "${VARIANTS[@]}"; do
        if [ -n "${users[$VARIANT]:-}" ]; then
            echo "   ${VARIANT}: ${users[$VARIANT]}"
        fi
    done
    echo ""
fi