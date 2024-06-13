#!/bin/bash

# Source list_images.sh to get the list of Docker images
source "$(dirname "$0")/list_images.sh"

# Define remote servers
REMOTE_SERVERS=("user@remote-server1" "user@remote-server2")

# Function to configure Docker containers
configure_containers() {
    echo "Enter the number of the image you want to configure (or 'all' to configure all images):"
    read -r selection
    if [[ "$selection" == "all" ]]; then
        for server in "${REMOTE_SERVERS[@]}"; do
            for image in "${DOCKER_IMAGES[@]}"; do
                echo "Configuring container for $image on $server..."
                ssh "$server" "docker ps -q --filter ancestor=$image | xargs docker inspect"
                # Add specific configuration commands here
            done
        done
    elif [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -le "${#DOCKER_IMAGES[@]}" ]; then
        image="${DOCKER_IMAGES[$((selection-1))]}"
        for server in "${REMOTE_SERVERS[@]}"; do
            echo "Configuring container for $image on $server..."
            ssh "$server" "docker ps -q --filter ancestor=$image | xargs docker inspect"
            # Add specific configuration commands here
        done
    else
        echo "Invalid selection!"
    fi
}

configure_containers

