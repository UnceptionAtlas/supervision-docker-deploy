#!/bin/bash

# Define the list of Docker images for the supervision system
DOCKER_IMAGES=(
    "prom/prometheus:latest"
    "grafana/grafana:latest"
    "prom/alertmanager:latest"
    "prom/node-exporter:latest"
)

# Function to list available Docker images
list_images() {
    echo "Available Docker images for the supervision system:"
    for i in "${!DOCKER_IMAGES[@]}"; do
        echo "$((i+1))) ${DOCKER_IMAGES[$i]}"
    done
}

list_images

