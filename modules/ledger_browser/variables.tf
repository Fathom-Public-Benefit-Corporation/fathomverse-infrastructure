variable "docker_network_name" {
  description = "Name of the Docker network"
  type        = string
  default     = "sandbox"
}

variable "indy_network_name" {
  description = "Name of the Indy network"
  type        = string
  default     = "fathomverse"
}

variable "ipv4_address" {
  description = "IPv4 address for the ledger browser container"
  type        = string
  default     = "10.133.133.9"
}

variable "web_server_host_port" {
  description = "Host port for the web server"
  type        = string
  default     = "9000"
}
