# infrastructure

```
.
├── environments
│   ├── dev
│   └── prod
├── main.tf
├── modules
│   ├── careeronestop
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── indy_node
│       ├── etc_indy
│       ├── lib_indy
│       ├── log_indy
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── versions.tf
├── provider.tf
├── README.md
├── scripts
│   ├── add_ddos_protection_iptables_rule.sh
│   ├── check_network_connectivity.sh
│   ├── cleanup.sh
│   ├── generate_random_seeds.sh
│   ├── ip_tables_utils.sh
│   └── set_iptables.sh
├── scripts.tf
├── terraform.tfvars
└── variables.tf
```

## How to initialize, plan, and apply

1. Initialize the Terraform project: `terraform init`
2. Plan the Terraform configuration: `terraform plan`
3. Apply the Terraform configuration: `terraform apply -var-file=terraform.tfvars -auto-approve`

### Getting Started with `Trustee`
Prerequisite: 
- Running Ubuntu 18.04 LTS
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
Create a wallet and open the wallet.
The seed for Trustee `V4SGRU86Z58d6TV7PBUe6f` is `000000000000000000000000Trustee1`.
```terminal
john:indy> did new seed=000000000000000000000000Trustee1 

Did "V4SGRU86Z58d6TV7PBUe6f has been created with "~CoRER63DVYnWZtK8uAzNbx" verkey
```
Building a transaction
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