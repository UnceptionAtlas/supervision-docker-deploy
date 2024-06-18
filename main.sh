#!/bin/bash

# Function to display the welcome message
display_welcome() {
    echo "==========================================="
    echo "Welcome to the Unception Supervision System"
    echo "Deployment Script"
    echo "==========================================="
    echo
}

# Function to display the main menu
display_menu() {
    echo "==== Supervision System Deployment Menu ===="
    echo "1) List Docker images"
    echo "2) Pull Docker images"
    echo "3) Deploy Docker images"
    echo "4) Exit"
    echo "==========================================="
}

# Function to display the list menu
display_list_menu() {
    echo "==== List Docker Images Menu ===="
    echo "1) List pulled images"
    echo "2) Return to main menu"
    echo "================================="
}

# Function to list Docker images
list_docker_images() {
    while true; do
        clear
        display_list_menu
        echo -n "Enter your choice: "
        read -r list_choice
        case $list_choice in
            1) source "$(dirname "$0")/list_pulled_images.sh";;
            2) break;;
            *) echo "Invalid choice! Please try again.";;
        esac
        echo "Press Enter to continue..."
        read -r
    done
}

# Function to pull Docker images
pull_docker_images() {
    source "$(dirname "$0")/pull_images.sh"
}

# Function to deploy Docker images
deploy_docker_images() {
    source "$(dirname "$0")/deploy_images.sh"
}

# Main script loop
while true; do
    clear # Clear the screen for better readability
    display_welcome
    display_menu
    echo -n "Enter your choice: "
    read -r choice
    case $choice in
        1) list_docker_images;;
        2) pull_docker_images;;
        3) deploy_docker_images;;
        4) echo "Exiting..."; exit 0;;
        *) echo "Invalid choice! Please try again.";;
    esac
    echo "Press Enter to continue..."
    read -r # This pause prevents the menu from appearing again immediately
done

