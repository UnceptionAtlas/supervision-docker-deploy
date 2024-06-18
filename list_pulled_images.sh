#!/bin/bash

# Function to list pulled Docker images
list_pulled_images() {
    echo "Pulled Docker images on local machine / remote servers:"
    echo "-------------------------------------------"
    docker images --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}"
    echo "-------------------------------------------"
    
    echo -n "Do you want to perform an action on any image? (yes/no): "
    read -r response
    if [[ "$response" == "yes" ]]; then
        echo -n "Enter the image ID you want to act on: "
        read -r image_id
        check_and_perform_action "$image_id"
    fi
}

# Function to check if the Docker image exists and list possible actions
check_and_perform_action() {
    local image_id="$1"
    local image_exists=$(docker images --format "{{.ID}}" | grep "^$image_id$")

    if [[ -z "$image_exists" ]]; then
        echo "Action cannot be performed. Image ID $image_id does not exist."
        return
    fi

    local image_status=$(docker inspect --format '{{.State.Status}}' "$image_id" 2>/dev/null)
    if [[ $? -ne 0 ]]; then
        image_status="not available"
    fi

    echo "Image ID $image_id is currently $image_status."
    echo "Choose an action for image ID $image_id:"
    echo "1) Start"
    echo "2) Stop"
    echo "3) Configure"
    echo "4) Remove"

    echo -n "Enter your choice: "
    read -r action_choice
    case $action_choice in
        1) docker start "$image_id";;
        2) docker stop "$image_id";;
        3) source "$(dirname "$0")/configure_image.sh" "$image_id";;
        4) docker rmi "$image_id";;
        *) echo "Invalid choice! Please try again.";;
    esac
}

# Main call
list_pulled_images

