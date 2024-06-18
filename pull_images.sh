#!/bin/bash

# Function to pull Docker images
pull_docker_images() {
    echo "Available Docker images for the supervision system:"
    echo "1) prom/prometheus:latest"
    echo "2) grafana/grafana:latest"
    echo "3) prom/alertmanager:latest"
    echo "4) prom/node-exporter:latest"
    echo "5) elasticsearch/elasticsearch:latest"
    echo "6) logstash/logstash:latest"

    echo -n "Do you want to pull a specific image or all images? (1 for specific, 2 for all): "
    read -r choice
    case $choice in
        1)
            echo -n "Enter the image name (including tag) to pull: "
            read -r image_name
            docker pull "$image_name"
            ;;
        2)
            docker pull prom/prometheus:latest
            docker pull grafana/grafana:latest
            docker pull prom/alertmanager:latest
            docker pull prom/node-exporter:latest
            docker pull elasticsearch/elasticsearch:latest
            docker pull logstash/logstash:latest
            ;;
        *)
            echo "Invalid choice! Please try again."
            ;;
    esac
}

# Main call
pull_docker_images

