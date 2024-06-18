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

# Function to pull Docker images
pull_images() {
    for image in "${IMAGES[@]}"; do
        echo "Pulling $image..."
        docker pull "$image" || echo "Failed to pull $image"
    done
}

# Prompt for specific image or all
echo "Do you want to pull a specific image or all images?"
echo "1) Specific image"
echo "2) All images"
read -r pull_choice

case $pull_choice in
    1)
        echo "Enter the number of the image you want to pull:"
        for i in "${!IMAGES[@]}"; do
            echo "$((i+1))) ${IMAGES[$i]}"
        done
        read -r image_number
        if [[ $image_number -ge 1 && $image_number -le ${#IMAGES[@]} ]]; then
            docker pull "${IMAGES[$((image_number-1))]}" || echo "Failed to pull ${IMAGES[$((image_number-1))]}"
        else
            echo "Invalid choice!"
        fi
        ;;
    2) pull_images;;
    *) echo "Invalid choice!";;
esac

