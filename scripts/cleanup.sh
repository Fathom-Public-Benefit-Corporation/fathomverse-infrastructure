#!/bin/bash

# Navigate to the script's directory
cd "$(dirname "$0")"

# Remove specified directories and files
sudo rm -rf ../modules/indy_node/lib_indy/fathomverse/data/
sudo rm -rf ../modules/indy_node/lib_indy/fathomverse/keys/
sudo rm -rf ../modules/indy_node/lib_indy/fathomverse/*.json
sudo rm -rf ../modules/indy_node/etc_indy/__pycache__/
sudo rm -rf ../modules/indy_node/lib_indy/plugins/
sudo rm -rf ../modules/indy_node/log_indy/fathomverse/*.log
sudo rm ../modules/indy_node/lib_indy/fathomverse/domain_transactions_genesis
sudo rm ../modules/indy_node/lib_indy/fathomverse/pool_transactions_genesis

rm ../modules/indy_node/.terraform.lock.hcl
rm -rf ../.terraform/
rm ../.terraform.lock.hcl
rm ../terraform.tfstate
rm ../terraform.tfstate.backup

echo "Cleanup completed."
