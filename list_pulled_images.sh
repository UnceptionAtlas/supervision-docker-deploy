#!/bin/bash

# Define remote servers (if any)
REMOTE_SERVERS=("user@remote-server1" "user@remote-server2")

# Function to list pulled Docker images on the local machine
list_local_pulled_images() {
    echo "Pulled Docker images on local machine:"
    docker images --format "table {{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.Size}}"
}

# Function to list pulled Docker images on remote servers
list_remote_pulled_images() {
    for server in "${REMOTE_SERVERS[@]}"; do
        echo "Pulled Docker images on $server:"
        ssh "$server" "docker images --format 'table {{.Repository}}:{{.Tag}}\t{{.ID}}\t{{.Size}}'"
    done
}

# Prompt user for local or remote
echo "Choose where to list pulled images:"
echo "1) Local machine"
echo "2) Remote servers"
read -r location_choice

case $location_choice in
    1) list_local_pulled_images;;
    2) list_remote_pulled_images;;
    *) echo "Invalid choice!";;
esac

