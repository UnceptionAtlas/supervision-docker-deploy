#!/bin/bash

# Available Docker images for the supervision system
IMAGES=(
    "prom/prometheus:latest"
    "grafana/grafana:latest"
    "prom/alertmanager:latest"
    "prom/node-exporter:latest"
    "elasticsearch/elasticsearch:latest"
    "logstash/logstash:latest"
)

# Function to list available Docker images
list_available_images() {
    echo "Available Docker images for the supervision system:"
    for i in "${!IMAGES[@]}"; do
        echo "$((i+1))) ${IMAGES[$i]}"
    done
}

# Display the list of available images
list_available_images

