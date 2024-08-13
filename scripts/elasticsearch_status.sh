#!/bin/bash

# Function to check if Elasticsearch container is up and running
check_elasticsearch_status() {
    CONTAINER_NAME="es01"

    # Check if the container is running
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Elasticsearch container '$CONTAINER_NAME' is running."
        
        # Optional: Check if Elasticsearch service inside the container is healthy
        HEALTH_STATUS= check_health $CONTAINER_NAME
        if [ "$HEALTH_STATUS" == "" ]; then
            echo "Elasticsearch container '$CONTAINER_NAME' is healthy."
        else
            echo "Elasticsearch container '$CONTAINER_NAME' is running but not healthy."
        fi
    else
        echo "Elasticsearch container '$CONTAINER_NAME' is not running."
    fi
}

check_health(){
	# Check if the logs contain the string "error"
 if podman logs $1 | grep "ERROR:" | grep -qi "error" >>/dev/null 2>&1; then
    echo "ERROR"
 else
    echo ""
 fi

}
