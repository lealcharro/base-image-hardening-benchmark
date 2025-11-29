#!/usr/bin/env bash

set -euo pipefail

# Obtener git sha para identificar las imagenes
GIT_SHA=$(git rev-parse --short HEAD)

# Variantes de imagenes a inspeccionar
VARIANTS=("ubuntu" "slim" "alpine")

for VARIANT in "${VARIANTS[@]}"; do
    IMAGE_NAME="app-${VARIANT}:${GIT_SHA}"

    if ! docker image inspect "${IMAGE_NAME}" &> /dev/null; then
        echo ">>> ${VARIANT}:null"
        continue
    fi

    # Obtener el Bounding Set del proceso principal (pid 1) y decodificarlo
    HEX_CAPS=$(docker run --rm --user=root "${IMAGE_NAME}" cat /proc/1/status | grep "CapBnd" | awk '{print $2}')

    if [ -z "$HEX_CAPS" ]; then
        echo ">>> ${VARIANT}:null"
    else
        # Decodificar el hex a nombres de capabilities
        DECODED_CAPS=$(docker run --rm --user=root "${IMAGE_NAME}" capsh --decode="${HEX_CAPS}")

        if [ -z "$DECODED_CAPS" ]; then
            echo ">>> ${VARIANT}:null"
        else
            # Extraer solo las capabilities (después del =)
            CAPS=$(echo "${DECODED_CAPS}" | cut -d'=' -f2)
            echo ">>> ${VARIANT}:${CAPS}"
        fi
    fi
done

# Prueba con seccomp
echo -n ">>> seccomp_test:"
if [ -f "docker/seccomp-profile.json" ]; then
    if docker run --rm \
        --security-opt seccomp=docker/seccomp-profile.json \
        "app-alpine:${GIT_SHA}" \
        sh -c "exit 0"; then
        echo "success"
    else
        echo "failed"
    fi
else
    echo "profile_not_found"
fi
