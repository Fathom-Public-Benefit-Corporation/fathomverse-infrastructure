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

# Function to safely remove a file if it exists
safe_remove() {
    local file=$1
    if [ -f "$file" ]; then
        sudo rm "$file" && echo "Removed $file"
    else
        echo "File $file does not exist, skipping removal."
    fi
}

# Function to copy files
copy_files() {
    local target_dir=$1
    echo "Copying genesis files to $target_dir ..."
    cp -v "$DOMAIN_GENESIS_FILE" "$target_dir"
    cp -v "$POOL_GENESIS_FILE" "$target_dir"
}

# Iterate over each target directory, remove old files and copy the new files
for dir in "${TARGET_DIRECTORIES[@]}"; do
    if [ -d "$dir" ]; then
        echo "Processing $dir ..."
        safe_remove "$dir/domain_transactions_genesis"
        safe_remove "$dir/pool_transactions_genesis"
        copy_files "$dir"
    else
        echo "Directory $dir does not exist. Skipping."
    fi
done

echo "Genesis files copied successfully."
