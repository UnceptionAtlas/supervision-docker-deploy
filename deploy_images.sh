#!/bin/bash

# Source list_images.sh to get the list of Docker images
source "$(dirname "$0")/list_images.sh"

# Define remote servers
REMOTE_SERVERS=("user@remote-server1" "user@remote-server2")

# Define configuration for Docker containers
CONTAINER_CONFIGS=(
    "-p 9090:9090"
    "-p 3000:3000"
    "-p 9093:9093"
    "-p 9100:9100"
)

# Function to deploy Docker images
deploy_images() {
    echo "Enter the number of the image you want to deploy (or 'all' to deploy all images):"
    read -r selection
    if [[ "$selection" == "all" ]]; then
        for server in "${REMOTE_SERVERS[@]}"; do
            for i in "${!DOCKER_IMAGES[@]}"; do
                image="${DOCKER_IMAGES[$i]}"
                config="${CONTAINER_CONFIGS[$i]}"
                echo "Deploying $image on $server..."
                ssh "$server" "docker pull $image && docker run -d $config $image"
            done
        done
    elif [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -le "${#DOCKER_IMAGES[@]}" ]; then
        image="${DOCKER_IMAGES[$((selection-1))]}"
        config="${CONTAINER_CONFIGS[$((selection-1))]}"
        for server in "${REMOTE_SERVERS[@]}"; do
            echo "Deploying $image on $server..."
            ssh "$server" "docker pull $image && docker run -d $config $image"
        done
    else
        echo "Invalid selection!"
    fi
}

deploy_images

