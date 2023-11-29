variable "docker_network_name" {
  description = "Name of the Docker network"
  type        = string
  default     = "sandbox"
}

variable "ipv4_address" {
  description = "IPv4 address for the tails server container"
  type        = string
  default     = "10.133.133.10"
}

variable "genesis_url" {
  description = "The Genesis URL"
  type        = string
}
