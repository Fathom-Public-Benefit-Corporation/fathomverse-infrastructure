#!/bin/bash

NETWORK_NAME="fathomverse"
NETWORK_SUBNET="10.133.133.0/24"
NETWORK_GATEWAY="10.133.133.254"
CONTAINERS=("indy_node1_service" "indy_node2_service" "indy_node3_service" "indy_node4_service" "indy_controller1" "indy_controller2" "indy_controller3" "indy_controller4")

# Function to check if a Docker network exists
network_exists() {
    docker network ls | grep -w "$1" > /dev/null
}

# Function to check if a Docker container is connected to a network
container_connected_to_network() {
    docker network inspect "$1" | grep -w "$2" > /dev/null
}

# Function to disconnect container from network, if connected
disconnect_container_from_network() {
    local network=$1
    local container=$2

    if container_connected_to_network "$network" "$container"; then
        echo "Disconnecting $container from $network"
        docker network disconnect "$network" "$container"
    else
        echo "$container is not connected to $network"
    fi
}

# Function to connect container to network with specific IP, if not already connected
connect_container_to_network() {
    local network=$1
    local container=$2
    local ip=$3

    if ! container_connected_to_network "$network" "$container"; then
        echo "Connecting $container to $network with IP $ip"
        docker network connect --ip "$ip" "$network" "$container"
    else
        echo "$container is already connected to $network"
    fi
}

# Disconnect and remove network if it exists
if network_exists "$NETWORK_NAME"; then
    for container in "${CONTAINERS[@]}"; do
        disconnect_container_from_network "$NETWORK_NAME" "$container"
    done

    echo "Removing network $NETWORK_NAME"
    docker network rm "$NETWORK_NAME"
else
    echo "Network $NETWORK_NAME does not exist"
fi

# Create the Docker network if it doesn't exist
if ! network_exists "$NETWORK_NAME"; then
    echo "Creating network $NETWORK_NAME"
    docker network create --driver bridge --subnet "$NETWORK_SUBNET" --gateway "$NETWORK_GATEWAY" "$NETWORK_NAME"
else
    echo "Network $NETWORK_NAME already exists"
fi

# Connect containers to the network with specific IPs
connect_container_to_network "$NETWORK_NAME" "indy_node1_service" "10.133.133.1"
connect_container_to_network "$NETWORK_NAME" "indy_node2_service" "10.133.133.2"
connect_container_to_network "$NETWORK_NAME" "indy_node3_service" "10.133.133.3"
connect_container_to_network "$NETWORK_NAME" "indy_node4_service" "10.133.133.4"
connect_container_to_network "$NETWORK_NAME" "indy_controller1" "10.133.133.5"
connect_container_to_network "$NETWORK_NAME" "indy_controller2" "10.133.133.6"
connect_container_to_network "$NETWORK_NAME" "indy_controller3" "10.133.133.7"
connect_container_to_network "$NETWORK_NAME" "indy_controller4" "10.133.133.8"
