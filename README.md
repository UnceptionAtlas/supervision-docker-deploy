# Automated Supervision System Deployment with Docker

This project provides a bash script to automate the deployment of a supervision system using Docker. It facilitates the management of Docker images and containers for components such as Prometheus, Grafana, Alertmanager, and Node Exporter across remote servers.

## Features

- **List** available Docker images for the supervision system.
- **Pull** specific or all Docker images.
- **Deploy** Docker images on remote servers with specified configurations.
- **Configure** Docker containers to tailor the supervision system setup.

## Usage

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/yourusername/supervision-docker-deploy.git
    cd supervision-docker-deploy
    ```

2. **Make the Script Executable**:
    ```bash
    chmod +x supervision_deploy.sh
    ```

3. **Run the Script**:
    ```bash
    ./supervision_deploy.sh
    ```

4. **Follow the On-Screen Menu** to manage Docker images and deploy the supervision system.

## Docker Images Included

- **Prometheus**: `prom/prometheus:latest`
- **Grafana**: `grafana/grafana:latest`
- **Alertmanager**: `prom/alertmanager:latest`
- **Node Exporter**: `prom/node-exporter:latest`

## Configuration

The script allows for basic container configurations such as port mappings and volume mounts. Extend the configurations as needed for your specific supervision system setup.

## Requirements

- Docker installed on the local and remote servers.
- SSH access to the remote servers.

## License

[MIT](LICENSE)

