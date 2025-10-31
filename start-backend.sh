#!/usr/bin/env bash

set -euo pipefail

IMAGE_NAME="chaos-kitchen-backend"
CONTAINER_NAME="chaos-kitchen-backend"
BACKEND_PATH="./backend"
PORT=8000

# cleanup function
cleanup() {
    echo "Stopping container..."
    docker stop "$CONTAINER_NAME" >/dev/null 2>&1 || true
    docker rm "$CONTAINER_NAME" >/dev/null 2>&1 || true
    exit 0
}
trap cleanup INT

# check if Docker exists
if ! command -v docker >/dev/null 2>&1; then
    echo "Error: Docker is not installed or not in PATH."
    exit 1
fi

# stop and remove old container
echo "Cleaning up old container (if any)..."
docker stop "$CONTAINER_NAME" >/dev/null 2>&1 || true
docker rm "$CONTAINER_NAME" >/dev/null 2>&1 || true

# check for --build or -b flag
if [[ "${1:-}" == "--build" || "${1:-}" == "-b" ]]; then
    echo "Building Docker image..."
    docker build -t "$IMAGE_NAME" "$BACKEND_PATH"
else
    if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
        echo "Image not found. Building automatically..."
        docker build -t "$IMAGE_NAME" "$BACKEND_PATH"
    fi
fi

# run container
echo "Starting backend container..."
docker run -d -p ${PORT}:8000 --name "$CONTAINER_NAME" "$IMAGE_NAME" >/dev/null

if docker ps --filter "name=$CONTAINER_NAME" --filter "status=running" | grep -q "$CONTAINER_NAME"; then
    echo "Backend is running at http://localhost:${PORT}"
else
    echo "Failed to start backend container."
    exit 1
fi
