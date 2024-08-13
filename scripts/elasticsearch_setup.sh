#!/bin/bash

# Function to set up and start Elasticsearch Docker container
setup_elasticsearch() {
    # Check and kill processes on ports 5600, 5601, 9200, and 9201
    for PORT in 5600 5601 9200 9201; do
        kill_process_on_port $PORT
    done

    # Check if the network "elastic" exists and remove it if it does
    if docker network inspect elastic >/dev/null 2>&1; then
        echo "Network 'elastic' exists. Removing the network..."
        docker network rm -f elastic
    fi

    # Recreate the network "elastic"
    echo "Creating a new network 'elastic'..."
    docker network create elastic
    source ./scripts/modify_conflist.sh
    modify_conflist

    # Check if the Elasticsearch Docker image is pulled
    IMAGE_NAME="docker.elastic.co/elasticsearch/elasticsearch:8.15.0"
    if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
        echo "Docker image $IMAGE_NAME not found. Pulling the image..."
        docker pull $IMAGE_NAME
    else
        echo "Docker image $IMAGE_NAME is already pulled."
    fi

    # Run the Elasticsearch container
    CONTAINER_NAME="es01"
    echo "Starting Elasticsearch container $CONTAINER_NAME..."
    docker run -d --name $CONTAINER_NAME --network elastic -p 9200:9200 -p 9300:9300 $IMAGE_NAME

    echo "Elasticsearch container $CONTAINER_NAME started successfully."
}

