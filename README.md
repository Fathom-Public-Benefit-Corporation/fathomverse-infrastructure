# Hyperledger Indy and Hyperledger Aries Infrastructure

First initial use-case with [Fathom PBC](https://www.fathompbc.org/)

```terminal
.
├── environments
│   ├── local
│   └── testnet
├── main.tf
├── modules
│   ├── aca_py
│   ├── indy_node1
│   ├── indy_node2
│   ├── indy_node3
│   ├── indy_node4
│   ├── ledger_browser
│   └── tails_server
├── provider.tf
├── README.md
├── scripts
│   ├── generate_random_seeds.sh
│   ├── sudo_cleanup_modules.sh
│   └── update_indy_genesis_files.sh
├── scripts.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
└── variables.tf
```

## How to initialize, plan, and apply

1. Initialize the Terraform project: `terraform init`
2. Plan the Terraform configuration: `terraform plan`
3. Apply the Terraform configuration: `terraform apply -var-file=terraform.tfvars -auto-approve`

### How to use scripts

To cleanup each node's cache, data, keys, log files, and plugins use the script:

- `sudo ./scripts/sudo_cleanup_modules.sh`

To generate a random seeds to be used foreach node use the script:

- `./scripts/generate_random_seed.sh`  
  - Generating new seeds requires one to recreate both genesis files.

To update each module's genesis file with `environments/local` genesis files use the script:

- `./scripts/update_indy_genesis_files.sh`

### Transacting on localhosted Hyperledger Indy network

Pre-requisites:

- Ubuntu 18.04 LTS
- Install [indy-cli](https://github.com/hyperledger/indy-sdk/blob/main/README.md#ubuntu-based-distributions-ubuntu-1604-and-1804)

```console
sudo apt-get install ca-certificates -y
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CE7709D068DB5E88
sudo add-apt-repository "deb https://repo.sovrin.org/sdk/deb bionic stable"
sudo apt-get update
sudo apt-get install -y indy-cli
```

Enter indy-cli

```terminal
user@localhost$ indy-cli

indy> wallet create JOHN key=...

...

indy> wallet open JOHN key=...
```

Create a wallet and open the wallet, then create Trustees and Stewards in the wallet.

### Getting Started with `Trustee`

The seed for a Trustee of `V4SGRU86Z58d6TV7PBUe6f` is `000000000000000000000000Trustee1`.  
The seed for a Trustee of `LnXR1rPnncTPZvRdmJKhJQ` is `000000000000000000000000Trustee2`.  
The seed for a Trustee of `PNQm3CwyXbN5e39Rw3dXYx` is `000000000000000000000000Trustee3`.  

```terminal
JOHN:indy> did new seed=000000000000000000000000Trustee1 
Did "V4SGRU86Z58d6TV7PBUe6f" has been created with "~CoRER63DVYnWZtK8uAzNbx" verkey
JOHN:indy> did new seed=000000000000000000000000Trustee2
Did "LnXR1rPnncTPZvRdmJKhJQ" has been created with "~RTBtVN3iwcFhbWZzohFTMi" verkey
JOHN:indy> did new seed=000000000000000000000000Trustee3
Did "PNQm3CwyXbN5e39Rw3dXYx" has been created with "~AHtGeRXtGjVfXALtXP9WiX" verkey
```

### Getting Started with `Steward`

The seed for a Steward of `Th7MpTaRZVRYnPiabds81Y` is `000000000000000000000000Steward1`.
The seed for a Steward of `EbP4aYNeTHL6q385GuVpRV` is `000000000000000000000000Steward2`.
The seed for a Steward of `4cU41vWW82ArfxJxHkzXPG` is `000000000000000000000000Steward3`.
The seed for a Steward of `TWwCRQRZ2ZHMJFn9TzLp7W` is `000000000000000000000000Steward4`.

```terminal
JOHN:indy> did new seed=000000000000000000000000Steward1
Did "Th7MpTaRZVRYnPiabds81Y" has been created with "~7TYfekw4GUagBnBVCqPjiC" verkey.
JOHN:indy> did new seed=000000000000000000000000Steward2
Did "EbP4aYNeTHL6q385GuVpRV" has been created with "~RHGNtfvkgPEUQzQNtNxLNu" verkey
JOHN:indy> did new seed=000000000000000000000000Steward3
Did "4cU41vWW82ArfxJxHkzXPG" has been created with "~EMoPA6HrpiExVihsVfxD3H" verkey
JOHN:indy> did new seed=000000000000000000000000Steward4
Did "TWwCRQRZ2ZHMJFn9TzLp7W" has been created with "~UhP7K35SAXbix1kCQV4Upx" verkey
```

### Registering a new did using the ledger browser

- Option 1. One can use a did seed of `00000000000000000000000Endorser1` to create a new did
- Option 2. One can use the Did `JJ5mHotESZ9a2W88tLB3FE` and verkey `~HWURmJQ7nyL6vAxhb39n2o` to register a did that is derived from the seed `00000000000000000000000Endorser2`

More information can be found in the `environments/local/README.md` file.
