variable "aries_cloudagent_image" {
  description = "Docker image for Aries Cloud Agent"
  type        = string
}

variable "aries_cloudagent_ipv4_address" {
  description = "IPv4 address for the Aries Cloud Agent within the Docker network"
  type        = string
  default     = "10.133.133.12"
}

variable "aries_cloudagent_name" {
  description = "Name for Aries Cloud Agent container"
  type        = string
  default     = "aries-cloud-agent"
}

variable "aries_cloudagent_external_ports" {
  description = "List of external ports for the Docker container."
  type        = list(number)
  default     = [8030, 8031]
}

variable "acapy_static_args_path" {
  description = "Path to the Aries Cloud Agent static arguments file"
  type        = string
  default     = "./acapy-static-args.yml"
}

variable "docker_network_name" {
  description = "Name of the Docker network"
  type        = string
  default     = "sandbox"
}

variable "genesis_transaction_list_path" {
  description = "Path to the genesis transaction list file"
  type        = string
  default     = "./genesis-transaction-list.yml"
}

variable "ledger_browser_id" {
  description = "ID of the ledger browser container"
  type        = string
}


variable "postgres_wallet_image" {
  description = "Docker image for the Postgres wallet"
  type        = string
  default     = "postgres:14-alpine"
}

variable "postgres_wallet_name" {
  description = "Name for the Postgres wallet container"
  type        = string
  default     = "postgres-wallet"
}

variable "postgres_wallet_port" {
  description = "External port for the Postgres wallet"
  type        = number
  default     = 5432
}

variable "postgres_wallet_data_path" {
  description = "Path for Postgres wallet data storage"
  type        = string
  default     = "./postgres-wallet"
}

variable "postgres_wallet_ipv4_address" {
  description = "IPv4 address for the Postgres wallet within the Docker network"
  type        = string
  default     = "10.133.133.11"
}

variable "postgres_user" {
  description = "Username for the Postgres database"
  type        = string
  default     = "walletuser"
}

variable "postgres_password" {
  description = "Password for the Postgres database"
  type        = string
  default     = "walletpassword"
}
