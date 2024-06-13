#!/bin/bash

# Source list_images.sh to get the list of Docker images
source "$(dirname "$0")/list_images.sh"

# Function to check if Docker image is pulled
check_image() {
    echo "Enter the number of the image you want to check (or 'all' to check all images):"
    read -r selection
    if [[ "$selection" == "all" ]]; then
        for image in "${DOCKER_IMAGES[@]}"; do
            if docker images -q "$image" > /dev/null 2>&1; then
                echo "Image $image is already pulled."
            else
                echo "Image $image is not pulled."
            fi
        done
    elif [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -le "${#DOCKER_IMAGES[@]}" ]; then
        image="${DOCKER_IMAGES[$((selection-1))]}"
        if docker images -q "$image" > /dev/null 2>&1; then
            echo "Image $image is already pulled."
        else
            echo "Image $image is not pulled."
        fi
    else
        echo "Invalid selection!"
    fi
}

check_image

