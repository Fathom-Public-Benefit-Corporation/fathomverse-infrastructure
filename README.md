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
│   └── generate_random_seeds.sh
├── scripts.tf
├── terraform.tfstate
├── terraform.tfstate.backup
├── terraform.tfvars
└── variables.tf
```

## How to initialize and apply

1. Change to the desired environment directory: `cd environments/dev` or `cd environments/prod`
2. Initialize the Terraform project: `terraform init`
3. Apply the Terraform configuration: `terraform apply`


