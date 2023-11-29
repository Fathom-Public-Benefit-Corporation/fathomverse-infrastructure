#!/bin/bash

# Get the absolute path to the directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define the base directory for the modules relative to the script location
BASE_DIR="$SCRIPT_DIR/../modules"

# Array of module names
MODULES=("indy_node1" "indy_node2" "indy_node3" "indy_node4")

# Function to safely remove a directory if it exists
safe_remove_dir() {
    local dir_path="$1"
    if [ -d "$dir_path" ]; then
        echo "Removing directory: $dir_path"
        sudo rm -rf "$dir_path"
    else
        echo "Directory not found, skipping: $dir_path"
    fi
}

# Function to find and remove all info.json files within a directory
remove_info_json_files() {
    local dir_path="$1"
    sudo find "$dir_path" -type f -name '*info.json' -exec rm {} \;
    echo "Removed all info.json files in: $dir_path"
}

# Function to find and remove all .log files within a directory
remove_log_files() {
    local dir_path="$1"
    sudo find "$dir_path" -type f -name '*.log' -exec rm {} \;
    echo "Removed all .log files in: $dir_path"
}

# Loop through each module and perform the removals
for module in "${MODULES[@]}"; do
    module_etc_indy_path="$BASE_DIR/$module/etc_indy"
    module_lib_indy_path="$BASE_DIR/$module/lib_indy/fathomverse"
    module_log_indy_path="$BASE_DIR/$module/log_indy/fathomverse"

    # Remove all __pycache__ directories in etc_indy
    safe_remove_dir "$module_etc_indy_path/__pycache__"
    
    # Remove specific directories in lib_indy
    safe_remove_dir "$module_lib_indy_path/data"
    safe_remove_dir "$module_lib_indy_path/keys"
    safe_remove_dir "$module_lib_indy_path/../plugins" # Remove plugins directory

    # Remove all info.json files in lib_indy
    remove_info_json_files "$module_lib_indy_path"

    # Remove all .log files in log_indy
    remove_log_files "$module_log_indy_path"
done

echo "Cleanup completed."
