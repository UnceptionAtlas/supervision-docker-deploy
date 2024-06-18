#!/bin/bash

# Define remote servers (if any)
REMOTE_SERVERS=("user@remote-server1" "user@remote-server2")

# Function to list pulled Docker images on the local machine
list_local_pulled_images() {
    echo "Pulled Docker images on local machine:"
    docker images --format "table {{.ID}}\t{{.Repository}}:{{.Tag}}\t{{.Size}}"
}

# Function to list pulled Docker images on remote servers
list_remote_pulled_images() {
    for server in "${REMOTE_SERVERS[@]}"; do
        echo "Pulled Docker images on $server:"
        ssh "$server" "docker images --format 'table {{.ID}}\t{{.Repository}}:{{.Tag}}\t{{.Size}}'"
    done
}

# Function to check if an image ID exists locally
check_image_exists_local() {
    local image_id=$1
    docker images -q | grep -q "^$image_id$"
}

# Function to perform an action on a Docker image
perform_action_on_image() {
    echo "Enter the image ID you want to act on:"
    read -r image_id

    if check_image_exists_local "$image_id"; then
        echo "Choose an action for image ID $image_id:"
        echo "1) Start"
        echo "2) Stop"
        echo "3) Remove"
        read -r action_choice

        case $action_choice in
            1) 
                echo "Starting container from image ID $image_id..."
                docker run -d "$image_id" || echo "Failed to start container from image ID $image_id."
                ;;
            2) 
                echo "Stopping container with image ID $image_id..."
                docker stop $(docker ps -q --filter ancestor="$image_id") || echo "No running container found for image ID $image_id."
                ;;
            3) 
                echo "Removing image ID $image_id..."
                docker rmi -f "$image_id" || echo "Failed to remove image ID $image_id."
                ;;
            *) 
                echo "Invalid action!";;
        esac
    else
        echo "Action cannot be performed. Image ID $image_id does not exist."
    fi
}

# Prompt user for local or remote
echo "Choose where to list pulled images:"
echo "1) Local machine"
echo "2) Remote servers"
read -r location_choice

case $location_choice in
    1) 
        list_local_pulled_images
        echo "Do you want to perform an action on any image? (yes/no)"
        read -r perform_action
        if [[ "$perform_action" == "yes" ]]; then
            perform_action_on_image
        fi
        ;;
    2) 
        list_remote_pulled_images
        echo "Do you want to perform an action on any image? (yes/no)"
        read -r perform_action
        if [[ "$perform_action" == "yes" ]]; then
            echo "Action on remote images is not supported in this version."
        fi
        ;;
    *) echo "Invalid choice!";;
esac

