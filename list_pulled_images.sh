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

# Function to perform an action on a Docker image
perform_action_on_image() {
    echo "Enter the image ID you want to act on:"
    read -r image_id
    echo "Choose an action for image ID $image_id:"
    echo "1) Start"
    echo "2) Stop"
    echo "3) Remove"
    read -r action_choice

    case $action_choice in
        1) docker run -d "$image_id" ;;
        2) docker stop "$image_id" ;;
        3) docker rmi -f "$image_id" ;;
        *) echo "Invalid action!";;
    esac
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

