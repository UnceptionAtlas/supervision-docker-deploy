#!/bin/bash

# Ensure the log directory exists
if [ ! -d log ]; then
    mkdir log
fi

# Ensure the log file exists
if [ ! -f log/elasticsearch.log ]; then
    touch log/elasticsearch.log
fi

# Redirect all output to the log file
exec > log/elasticsearch.log 2>&1

# Function to kill processes using specific ports
kill_process_on_port() {
    PORT=$1
    PID=$(lsof -t -i:$PORT)
    if [ -n "$PID" ]; then
        echo "Killing process $PID using port $PORT..."
        kill -9 $PID
    else
        echo "No process found using port $PORT."
    fi
}

# Check and kill processes on ports 5600, 5601, 9200, and 9201
for PORT in 5600 5601 9200 9201; do
    kill_process_on_port $PORT
done

# Check for running Docker containers with image name containing "Elastic" (case-insensitive)
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

    docker ps -a --filter "network=elastic" --format "{{.ID}}" | xargs -r -I {} sh -c 'docker stop {}; docker rm {}'

    echo "Removing network 'elastic'..."
    docker network rm elastic
else
    echo "Network 'elastic' does not exist."
fi

# Create a new network "elastic"
echo "Creating a new network 'elastic'..."
docker network create elastic

echo "Done!"

