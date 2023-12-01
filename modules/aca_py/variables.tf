variable "aries_cloudagent_image" {
  description = "Docker image for Aries Cloud Agent"
  type        = string
}

variable "aries_cloudagent1_ipv4_address" {
  description = "IPv4 address for the Aries Cloud Agent within the Docker network"
  type        = string
  default     = "10.133.133.12"
}

variable "aries_cloudagent2_ipv4_address" {
  description = "IPv4 address for the Aries Cloud Agent within the Docker network"
  type        = string
  default     = "10.133.133.13"
}

variable "aries_cloudagent1_name" {
  description = "Name for Aries Cloud Agent 1 container"
  type        = string
  default     = "aries-cloud-agent"
}

variable "aries_cloudagent2_name" {
  description = "Name for Aries Cloud Agent 2 container"
  type        = string
  default     = "aries-mediator-agent"
}

variable "aries_cloudagent1_external_ports" {
  description = "List of external ports for the Docker container."
  type        = list(number)
  default     = [8030, 8031]
}

variable "aries_cloudagent2_external_ports" {
  description = "List of external ports for the Docker container."
  type        = list(number)
  default     = [8032, 8033]
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
