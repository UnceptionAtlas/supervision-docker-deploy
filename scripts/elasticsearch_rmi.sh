#!/bin/bash

# Function to remove the Elasticsearch Docker image
remove_image() {
    IMAGE_NAME="docker.elastic.co/elasticsearch/elasticsearch:8.15.0"

    # Check for running containers associated with the image
    CONTAINER_ID=$(docker ps -a --filter "ancestor=$IMAGE_NAME" --format "{{.ID}}")
    if [ -n "$CONTAINER_ID" ]; then
        echo "Stopping and removing container associated with the image $IMAGE_NAME..."
        docker stop $CONTAINER_ID
        docker rm -f $CONTAINER_ID
    else
        echo "No running containers associated with the image $IMAGE_NAME."
    fi

    # Check and kill processes on ports 9200 and 9201
    for PORT in 9200 9201; do
        kill_process_on_port $PORT
    done

    # Remove the Docker image
    echo "Removing Docker image $IMAGE_NAME..."
    docker rmi $IMAGE_NAME

    # Verify if the image was successfully removed
    if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
        echo "Docker image $IMAGE_NAME removed successfully."
    else
        echo "Failed to remove Docker image $IMAGE_NAME." >> log/elasticsearch.log
    fi
}

