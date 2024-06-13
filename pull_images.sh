#!/bin/bash

# Source list_images.sh to get the list of Docker images
source "$(dirname "$0")/list_images.sh"

# Function to pull Docker images
pull_images() {
    echo "Enter the number of the image you want to pull (or 'all' to pull all images):"
    read -r selection
    if [[ "$selection" == "all" ]]; then
        for image in "${DOCKER_IMAGES[@]}"; do
            echo "Pulling $image..."
            docker pull "$image"
        done
    elif [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -le "${#DOCKER_IMAGES[@]}" ]; then
        image="${DOCKER_IMAGES[$((selection-1))]}"
        echo "Pulling $image..."
        docker pull "$image"
    else
        echo "Invalid selection!"
    fi
}

pull_images

