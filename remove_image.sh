#!/bin/bash

# Source list_images.sh to get the list of Docker images
source "$(dirname "$0")/list_images.sh"

# Function to remove Docker image
remove_image() {
    echo "Enter the number of the image you want to remove (or 'all' to remove all images):"
    read -r selection
    if [[ "$selection" == "all" ]]; then
        for image in "${DOCKER_IMAGES[@]}"; do
            echo "Removing image $image..."
            docker rmi -f "$image"
        done
    elif [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -le "${#DOCKER_IMAGES[@]}" ]; then
        image="${DOCKER_IMAGES[$((selection-1))]}"
        echo "Removing image $image..."
        docker rmi -f "$image"
    else
        echo "Invalid selection!"
    fi
}

remove_image

