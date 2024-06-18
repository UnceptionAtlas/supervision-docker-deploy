#!/bin/bash

# Mapping of display names to actual Docker images
declare -A IMAGES_MAP=(
    ["Prometheus"]="prom/prometheus:latest"
    ["Grafana"]="grafana/grafana:latest"
    ["Alertmanager"]="prom/alertmanager:latest"
    ["Node-Exporter"]="prom/node-exporter:latest"
    ["Elasticsearch"]="docker.elastic.co/elasticsearch/elasticsearch:8.14.1"
    ["Logstash"]="docker.elastic.co/logstash/logstash:8.14.1"
    ["Kibana"]="docker.elastic.co/kibana/kibana:8.14.1"
)

# Function to pull Docker images
pull_docker_images() {
    echo "Available Docker images for the supervision system:"
    image_names=("${!IMAGES_MAP[@]}") # Extract keys to array

    for i in "${!image_names[@]}"; do
        echo "$((i + 1))) ${image_names[$i]}"
    done
    echo "$(( ${#image_names[@]} + 1 ))) Pull all images"

    echo -n "Enter the number of the image to pull or choose the last option to pull all: "
    read -r choice

    if [[ "$choice" -ge 1 && "$choice" -le "${#image_names[@]}" ]]; then
        image_key="${image_names[$((choice - 1))]}"
        image="${IMAGES_MAP[$image_key]}"
        echo "Pulling image: $image_key ($image)"
        docker pull "$image"
    elif [[ "$choice" -eq "$(( ${#image_names[@]} + 1 ))" ]]; then
        echo "Pulling all images..."
        for image_key in "${image_names[@]}"; do
            image="${IMAGES_MAP[$image_key]}"
            echo "Pulling image: $image_key ($image)"
            docker pull "$image"
        done
    else
        echo "Invalid choice! Please try again."
    fi
}

# Main call
pull_docker_images

