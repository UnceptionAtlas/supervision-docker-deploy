#!/bin/bash

# Function to stop and remove Elasticsearch Docker container and network
remove_elasticsearch() {
    # Check for running Docker containers with image name containing "elastic" (case-insensitive)
    ES_CONTAINERS=$(docker ps --filter "name=elastic" --format "{{.ID}}")
    if [ -n "$ES_CONTAINERS" ]; then
        echo "Stopping running Elasticsearch Docker containers..."
        docker stop $ES_CONTAINERS
    else
        echo "No running Elasticsearch Docker containers found."
    fi

    # Check if the network "elastic" exists
    if docker network inspect elastic >/dev/null 2>&1; then
        echo "Network 'elastic' exists. Checking for associated containers..."

        # Stopping and removing the containers that are associated with the network name elastic
        CONTAINERS_TO_REMOVE=$(docker ps -a --filter "network=elastic" --format "{{.ID}}")
        if [ -n "$CONTAINERS_TO_REMOVE" ]; then
            echo "Stopping and removing containers associated with the 'elastic' network..."
            echo $CONTAINERS_TO_REMOVE | xargs -r -I {} sh -c 'docker stop {}; docker rm {}'
        else
            echo "No containers associated with the 'elastic' network."
        fi

        echo "Removing network 'elastic'..."
        docker network rm -f elastic
    else
        echo "Network 'elastic' does not exist."
    fi

    echo "Elasticsearch Docker container and network removed successfully."
}

