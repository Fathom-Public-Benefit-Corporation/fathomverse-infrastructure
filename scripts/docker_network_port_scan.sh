#!/usr/bin/env bash

set +x
set -e

# Default network name
DOCKER_NETWORK="sandbox"

# Function to display usage instructions
usage() {
    echo
    echo "Usage:"
    echo "$0 [-n DOCKER_NETWORK]"
    echo
    echo "Scans all containers in the specified Docker network for open ports."
    echo
}

# Function to check if required tools are installed
check_setup() {
    if ! which nmap &>/dev/null; then
        echo -e "[FAIL]\t Nmap is required. Please install it and re-run the script."
        exit 1
    fi

    if ! which docker &>/dev/null; then
        echo -e "[FAIL]\t Docker is required. Please install it and re-run the script."
        exit 1
    fi
}

# Function to get container names and their IP addresses in a Docker network
get_container_names_and_ips() {
    docker network inspect "$DOCKER_NETWORK" --format '{{range .Containers}}{{.Name}} {{.IPv4Address}} {{end}}' |
        sed 's,/.* ,\n,g' | awk NF
}

# Function to check connection on a given IP and port
check_connection() {
    echo -e "[...]\t Checking $1:$2"
    nmap -Pn -n -p "$2" "$1"
}

# Main function
main() {

    # Parse arguments
    while getopts ":n:" opt; do
        case $opt in
            n) DOCKER_NETWORK=$OPTARG;;
            *) usage; exit 1;;
        esac
    done

    # Check setup
    check_setup

    # Get container names and IPs
    mapfile -t CONTAINERS < <(get_container_names_and_ips)
    if [ ${#CONTAINERS[@]} -eq 0 ]; then
        echo -e "[FAIL]\t No containers found in the Docker network '$DOCKER_NETWORK'."
        exit 1
    fi

    echo -e "[INFO]\t Found ${#CONTAINERS[@]} containers in the network."

    # Run checks
    for container_info in "${CONTAINERS[@]}"; do
        CONTAINER_NAME=$(echo "$container_info" | awk '{print $1}')
        CONTAINER_IP=$(echo "$container_info" | awk '{print $2}')

        echo -e "[INFO]\t Processing container $CONTAINER_NAME with IP $CONTAINER_IP"
        
        # Get ports for each container. If no ports are found, use a default port list.
        PORTS=$(docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} {{end}}' "$CONTAINER_NAME" | tr ' ' '\n' | grep -o '[0-9]*' | tr '\n' ' ')
        
        if [ -z "$PORTS" ]; then
            echo -e "[INFO]\t No exposed ports found for $CONTAINER_NAME. Skipping port scan."
            continue
        fi

        for port in $PORTS; do
            check_connection "$CONTAINER_IP" "$port"
        done
    done
}

main "$@"
