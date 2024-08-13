#!/bin/bash

# Function to display help
display_help() {
    echo "Usage: $0 [option]"
    echo
    echo "Options:"
    echo "  setup          Set up and start the Elasticsearch Docker container."
    echo "  remove         Stop and remove the Elasticsearch Docker container and network."
    echo "  rmi            Remove the Elasticsearch Docker image after stopping containers and killing processes."
    echo "  help, -h, --help  Display this help message."
    echo
    echo "Examples:"
    echo "  $0 setup       Set up and start Elasticsearch."
    echo "  $0 remove      Stop and remove Elasticsearch."
    echo "  $0 rmi         Remove the Elasticsearch Docker image."
    echo "  $0 help        Display the help message."
}

# Function to kill processes using specific ports
kill_process_on_port() {
    PORT=$1
    PID=$(lsof -t -i:$PORT)
    if [ -n "$PID" ]; then
        echo "Killing process $PID using port $PORT..."
        kill -9 $PID
        echo "Process $PID using port $PORT has been killed." >> log/elasticsearch.log
    else
        echo "No process found using port $PORT."
    fi
}

