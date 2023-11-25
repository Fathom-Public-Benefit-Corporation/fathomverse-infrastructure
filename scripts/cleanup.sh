#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo privileges."
  exit 1
fi

# Define an array of directories to remove
directories=(
  "../modules/indy_node1/lib_indy/fathomverse/data/"
  "../modules/indy_node2/lib_indy/fathomverse/data/"
  "../modules/indy_node3/lib_indy/fathomverse/data/"
  "../modules/indy_node4/lib_indy/fathomverse/data/"
  "../modules/indy_node1/lib_indy/fathomverse/keys/"
  "../modules/indy_node2/lib_indy/fathomverse/keys/"
  "../modules/indy_node3/lib_indy/fathomverse/keys/"
  "../modules/indy_node4/lib_indy/fathomverse/keys/"
  "../modules/indy_node1/lib_indy/fathomverse/*.json"
  "../modules/indy_node2/lib_indy/fathomverse/*.json"
  "../modules/indy_node3/lib_indy/fathomverse/*.json"
  "../modules/indy_node4/lib_indy/fathomverse/*.json"
  "../modules/indy_node1/etc_indy/__pycache__/"
  "../modules/indy_node2/etc_indy/__pycache__/"
  "../modules/indy_node3/etc_indy/__pycache__/"
  "../modules/indy_node4/etc_indy/__pycache__/"
  "../modules/indy_node1/lib_indy/plugins/"
  "../modules/indy_node2/lib_indy/plugins/"
  "../modules/indy_node3/lib_indy/plugins/"
  "../modules/indy_node4/lib_indy/plugins/"
  "../modules/indy_node1/log_indy/fathomverse/*.log"
  "../modules/indy_node2/log_indy/fathomverse/*.log"
  "../modules/indy_node3/log_indy/fathomverse/*.log"
  "../modules/indy_node4/log_indy/fathomverse/*.log"
  ".terraform/"
  ".terraform.lock.hcl"
  "terraform.tfstate"
  "terraform.tfstate.backup"
)

# Iterate through the directories and remove them
for dir in "${directories[@]}"; do
  if [ -e "$dir" ]; then
    sudo rm -rf "$dir"
    if [ $? -eq 0 ]; then
      echo "Removed: $dir"
    else
      echo "Failed to remove: $dir"
    fi
  else
    echo "Directory not found: $dir"
  fi
done

echo "Cleanup completed."
