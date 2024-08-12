#!/bin/bash

# Ensure the log directory exists
mkdir -p log

# Ensure the log file exists
if [ ! -f log/elasticsearch.log ]; then
    touch log/elasticsearch.log
fi

# Redirect all output to the log file
exec > log/elasticsearch.log 2>&1

# Check if the network "elastic" exists
if docker network inspect elastic >/dev/null 2>&1; then
    echo "Network 'elastic' exists. Removing it..."
    docker network rm elastic
else
    echo "Network 'elastic' does not exist."
fi

# Create a new network "elastic"
echo "Creating a new network 'elastic'..."
docker network create elastic

echo "Done!"

