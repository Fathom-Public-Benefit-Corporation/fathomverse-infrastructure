#!/bin/bash

# Determine the directory where this script resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to generate or preserve seed in a specific .env file
function generate_or_preserve_seed {
    local env_file="$1"
    local env_path="$SCRIPT_DIR/../$env_file"

    if [ -f "$env_path" ]; then
        echo -e "[...]\t $env_file already exists. Preserving existing seed."
    else
        echo -e "[...]\t Storing random seed in $env_file"
        echo "INDY_NODE_SEED=$(head -c 32 /dev/random | base64 | head -c 32)" > "$env_path"
        echo -e "[OK]\t Seed stored in $env_file"
    fi
}

# Generate or preserve seeds for each node environment file
generate_or_preserve_seed ".node1.env"
generate_or_preserve_seed ".node2.env"
generate_or_preserve_seed ".node3.env"
generate_or_preserve_seed ".node4.env"
