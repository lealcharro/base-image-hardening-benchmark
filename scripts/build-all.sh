#!/usr/bin/env bash

set -euo pipefail

# Obtener git sha
GIT_SHA=$(git rev-parse --short HEAD)

# Nuestras imagnes docker a construir
VARIANTS=("ubuntu" "slim" "alpine")

# Build
for VARIANT in "${VARIANTS[@]}"; do
  echo "Building app-${VARIANT}..."
  docker build -t "app-${VARIANT}:${GIT_SHA}" -f "docker/Dockerfile.${VARIANT}" .
done

echo "All images built successfully!"
