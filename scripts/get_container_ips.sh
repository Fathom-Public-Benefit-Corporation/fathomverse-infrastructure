#!/bin/bash

# Script to fetch IP addresses of specific Docker containers

# Define the container names
CONTAINERS=(
    "indy_node1_service"
    "indy_node2_service"
    "indy_node3_service"
    "indy_node4_service"
)

# Output file
OUTPUT_FILE="container_ips.txt"

# Clear the output file if it already exists
> "$OUTPUT_FILE"

# Function to fetch and write IP address
fetch_and_write_ip() {
    local container=$1
    local ip

    # Fetch the IP address of the container
    ip=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$container")

    # Write to the output file
    echo "$ip" >> "$OUTPUT_FILE"
}

# Iterate over each container and process
for container in "${CONTAINERS[@]}"; do
    echo "Processing $container..."
    fetch_and_write_ip "$container"
done

echo "IP addresses written to $OUTPUT_FILE."
