#!/bin/bash

# Script to copy genesis files to indy node directories

# Define the source files
DOMAIN_GENESIS_FILE="environments/local/domain_transactions_genesis"
POOL_GENESIS_FILE="environments/local/pool_transactions_genesis"

# Define the target directories
TARGET_DIRECTORIES=(
    "modules/indy_node1/lib_indy/fathomverse"
    "modules/indy_node2/lib_indy/fathomverse"
    "modules/indy_node3/lib_indy/fathomverse"
    "modules/indy_node4/lib_indy/fathomverse"
)

# Function to copy files
copy_files() {
    local target_dir=$1
    echo "Copying genesis files to $target_dir ..."
    cp -v "$DOMAIN_GENESIS_FILE" "$target_dir"
    cp -v "$POOL_GENESIS_FILE" "$target_dir"
}

# Iterate over each target directory and copy the files
for dir in "${TARGET_DIRECTORIES[@]}"; do
    if [ -d "$dir" ]; then
        copy_files "$dir"
    else
        echo "Directory $dir does not exist. Skipping."
    fi
done

echo "Genesis files copied successfully."
