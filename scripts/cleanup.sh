#!/bin/bash

# Navigate to the script's directory
cd "$(dirname "$0")"

# Remove specified directories and files
sudo rm -rf ../modules/indy_node1/lib_indy/fathomverse/data/
sudo rm -rf ../modules/indy_node2/lib_indy/fathomverse/data/
sudo rm -rf ../modules/indy_node3/lib_indy/fathomverse/data/
sudo rm -rf ../modules/indy_node4/lib_indy/fathomverse/data/

sudo rm -rf ../modules/indy_node1/lib_indy/fathomverse/keys/
sudo rm -rf ../modules/indy_node2/lib_indy/fathomverse/keys/
sudo rm -rf ../modules/indy_node3/lib_indy/fathomverse/keys/
sudo rm -rf ../modules/indy_node4/lib_indy/fathomverse/keys/

sudo rm -rf ../modules/indy_node1/lib_indy/fathomverse/*.json
sudo rm -rf ../modules/indy_node2/lib_indy/fathomverse/*.json
sudo rm -rf ../modules/indy_node3/lib_indy/fathomverse/*.json
sudo rm -rf ../modules/indy_node4/lib_indy/fathomverse/*.json

sudo rm -rf ../modules/indy_node1/etc_indy/__pycache__/
sudo rm -rf ../modules/indy_node2/etc_indy/__pycache__/
sudo rm -rf ../modules/indy_node3/etc_indy/__pycache__/
sudo rm -rf ../modules/indy_node4/etc_indy/__pycache__/

sudo rm -rf ../modules/indy_node1/lib_indy/plugins/
sudo rm -rf ../modules/indy_node2/lib_indy/plugins/
sudo rm -rf ../modules/indy_node3/lib_indy/plugins/
sudo rm -rf ../modules/indy_node4/lib_indy/plugins/

sudo rm -rf ../modules/indy_node1/log_indy/fathomverse/*.log
sudo rm -rf ../modules/indy_node2/log_indy/fathomverse/*.log
sudo rm -rf ../modules/indy_node3/log_indy/fathomverse/*.log
sudo rm -rf ../modules/indy_node4/log_indy/fathomverse/*.log

sudo rm ../modules/indy_node1/lib_indy/fathomverse/domain_transactions_genesis
sudo rm ../modules/indy_node2/lib_indy/fathomverse/domain_transactions_genesis
sudo rm ../modules/indy_node3/lib_indy/fathomverse/domain_transactions_genesis
sudo rm ../modules/indy_node4/lib_indy/fathomverse/domain_transactions_genesis

sudo rm ../modules/indy_node1/lib_indy/fathomverse/pool_transactions_genesis
sudo rm ../modules/indy_node2/lib_indy/fathomverse/pool_transactions_genesis
sudo rm ../modules/indy_node3/lib_indy/fathomverse/pool_transactions_genesis
sudo rm ../modules/indy_node4/lib_indy/fathomverse/pool_transactions_genesis

rm -rf ../.terraform/
rm ../.terraform.lock.hcl
rm ../terraform.tfstate
rm ../terraform.tfstate.backup

echo "Cleanup completed."
