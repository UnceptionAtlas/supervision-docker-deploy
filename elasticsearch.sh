#!/bin/bash

# Ensure the log directory exists
mkdir -p log

# Ensure the log file exists
touch log/elasticsearch.log

# Redirect all output to both the CLI and the log file
exec > >(tee -a log/elasticsearch.log) 2>&1

# Load helper functions
source ./scripts/elasticsearch_helpers.sh

# User input to decide action
if [ $# -eq 0 ]; then
    echo "No option provided. Use 'help' for more information."
    exit 1
fi

case "$1" in
    setup)
        source ./scripts/elasticsearch_setup.sh
        setup_elasticsearch
        ;;
    remove)
        source ./scripts/elasticsearch_remove.sh
        remove_elasticsearch
        ;;
    rmi)
        source ./scripts/elasticsearch_rmi.sh
        remove_image
        ;;
    status)
        source ./scripts/elasticsearch_status.sh
        check_elasticsearch_status
        ;;
    help|-h|--help)
        display_help
        ;;
    *)
        echo "Invalid option. Use 'help' for more information."
        exit 1
        ;;
esac

echo "Done!"

