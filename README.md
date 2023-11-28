# fathomverse-infrastructure
First initial use-case with [Fathom PBC](https://www.fathompbc.org/)
```
.
├── environments
│   ├── local
│   └── testnet
├── main.tf
├── modules
│   ├── indy_node1
│   ├── indy_node2
│   ├── indy_node3
│   ├── indy_node4
│   └── ledger_browser
├── provider.tf
├── README.md
├── scripts
│   ├── docker_network_port_scan.sh
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

To scan for any internal exposed ports in each docker container attached to a network use the scripts:
```terminal
./scripts/docker_network_port_scan.sh
```
example output:
```console
[INFO]   Found 1 containers in the network.
[INFO]   Processing container ledger-browser with IP 10.133.133.9
[...]    Checking 10.133.133.9:8000

Starting Nmap 7.60 ( https://nmap.org ) at 2023-11-27 22:34 EST
Nmap scan report for 10.133.133.9
Host is up (0.00017s latency).

PORT     STATE SERVICE
8000/tcp open  http-alt

Nmap done: 1 IP address (1 host up) scanned in 0.03 seconds
```

### Transacting on localhosted Hyperledger Indy network
Pre-requisites  
- Ubuntu 18.04 LTS
- Install [indy-cli](https://github.com/hyperledger/indy-sdk/blob/main/README.md#ubuntu-based-distributions-ubuntu-1604-and-1804)
```
sudo apt-get install ca-certificates -y
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CE7709D068DB5E88
sudo add-apt-repository "deb https://repo.sovrin.org/sdk/deb bionic stable"
sudo apt-get update
sudo apt-get install -y indy-cli
```
Enter indy-cli
```terminal
indy-cli

indy>
```

Create a wallet and open the wallet, then create Trustees and Stewards.
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
```
JOHN:indy> did new seed=000000000000000000000000Steward1
Did "Th7MpTaRZVRYnPiabds81Y" has been created with "~7TYfekw4GUagBnBVCqPjiC" verkey.
JOHN:indy> did new seed=000000000000000000000000Steward2
Did "EbP4aYNeTHL6q385GuVpRV" has been created with "~RHGNtfvkgPEUQzQNtNxLNu" verkey
JOHN:indy> did new seed=000000000000000000000000Steward3
Did "4cU41vWW82ArfxJxHkzXPG" has been created with "~EMoPA6HrpiExVihsVfxD3H" verkey
JOHN:indy> did new seed=000000000000000000000000Steward4
Did "TWwCRQRZ2ZHMJFn9TzLp7W" has been created with "~UhP7K35SAXbix1kCQV4Upx" verkey
```
### Building a transaction
```terminal
pool(fathomverse):JOHN:did(V4S...e6f):indy> ledger nym did=V4SGRU86Z58d6TV7PBUe6f verkey=~CoRER63DVYnWZtK8uAzNbx role=TRUSTEE send=false

Transaction has been created:
     {"identifier":"V4SGRU86Z58d6TV7PBUe6f","operation":{"dest":"V4SGRU86Z58d6TV7PBUe6f","role":"0","type":"1","verkey":"~CoRER63DVYnWZtK8uAzNbx"},"protocolVersion":2,"reqId":1700440097985973563,"signature":"4NRq1AvXi7pLtVEhhzfFLwyXJoewXnNX5RhRJK4XxP8fYaZf7o36MLhktvAwTV1NB4W6dZrb1GiEJhfaL5cXS4Lb"}
```
Multi-signing a transaction (i.e., copy and paste "Building a transaction" result into `txn` field)
```terminal
pool(fathomverse):JOHN:did(V4S...e6f):indy> ledger sign-multi txn={"identifier":"V4SGRU86Z58d6TV7PBUe6f","operation":{"dest":"V4SGRU86Z58d6TV7PBUe6f","role":"0","type":"1","verkey":"~CoRER63DVYnWZtK8uAzNbx"},"protocolVersion":2,"reqId":1700440097985973563,"signature":"4NRq1AvXi7pLtVEhhzfFLwyXJoewXnNX5RhRJK4XxP8fYaZf7o36MLhktvAwTV1NB4W6dZrb1GiEJhfaL5cXS4Lb"}

Transaction has been signed:
{"identifier":"V4SGRU86Z58d6TV7PBUe6f","operation":{"dest":"V4SGRU86Z58d6TV7PBUe6f","role":"0","type":"1","verkey":"~CoRER63DVYnWZtK8uAzNbx"},"protocolVersion":2,"reqId":1700440097985973563,"signatures":{"V4SGRU86Z58d6TV7PBUe6f":"4NRq1AvXi7pLtVEhhzfFLwyXJoewXnNX5RhRJK4XxP8fYaZf7o36MLhktvAwTV1NB4W6dZrb1GiEJhfaL5cXS4Lb"}}
```
