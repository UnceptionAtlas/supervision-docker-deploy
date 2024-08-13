# Elasticsearch Setup and Management Scripts

This project contains a collection of Bash scripts to manage the setup, running, and removal of an Elasticsearch Docker container. The scripts are modular and designed to be scalable and extensible.

## Table of Contents

- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Usage](#usage)
- [Options](#options)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)

## Project Structure

```bash
elasticsearch_setup/
├── scripts/
│   ├── elasticsearch_setup.sh          # Script to set up and start the Elasticsearch container
│   ├── elasticsearch_remove.sh         # Script to stop and remove the Elasticsearch container and network
│   ├── elasticsearch_rmi.sh            # Script to remove the Elasticsearch Docker image
│   ├── elasticsearch_helpers.sh        # Helper functions and utilities
│   ├── modify_conflist.sh              # Script to modify the CNI configuration
│   └── elasticsearch_status.sh         # Script to check if the Elasticsearch container is running
└── elasticsearch.sh                    # Main entry point to execute the scripts
└── log/                                # Log directory
    └── elasticsearch.log               # Log file for the operations
```

## Requirements
- Docker: Ensure Docker is installed and running on your machine.
- Bash: These scripts are written for Unix-like environments with Bash.

## Usage

The main script elasticsearch.sh is used to manage the Elasticsearch Docker container. The script provides several options to set up, manage, and remove the container and associated resources.

## Options

- setup: Set up and start the Elasticsearch Docker container.
- remove: Stop and remove the Elasticsearch Docker container and network.
- rmi: Remove the Elasticsearch Docker image after stopping containers and killing processes on specified ports.
- status: Check if the Elasticsearch Docker container is up and running.
help, -h, --help: Display help information.

## Examples

1. **Set up and start Elasticsearch:**

```bash
./elasticsearch.sh setup
```

2. **Stop and remove Elasticsearch container and network:**

```bash
./elasticsearch.sh remove
```

3. **Remove the Elasticsearch Docker image:**

```bash
./elasticsearch.sh rmi
```

4. **Check if Elasticsearch is running:**

```bash
./elasticsearch.sh status
```

5. **Display help information:**

```bash
./elasticsearch.sh help
```

## Logs

All operations are logged in the log/elasticsearch.log file. The log directory and file are automatically created if they don't exist.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please create an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for details. 


This `README.md` provides an overview of the project structure, requirements, usage, and examples. It also includes sections on contributing and licensing. Feel free to customize it according to your specific needs or organizational standards.

