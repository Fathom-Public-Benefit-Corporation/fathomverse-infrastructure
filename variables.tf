###########################################################
# INDY NODE 
###########################################################
variable "indy_node_container_name" {
  description = "Name for the Docker container."
  type        = string
}

variable "indy_node_image" {
  description = "Docker image for the Indy Node."
  type        = string
  default     = "ghcr.io/hyperledger/indy-node-container/indy_node:1.12.6-ubuntu18-main"
}

variable "indy_node_external_ports" {
  description = "External ports for the Docker container."
  type        = list(number)
}

variable "indy_node_ip" {
  description = "IP address for the Indy Node."
  type        = string
}

variable "indy_node_port" {
  description = "Node port for the Indy Node."
  type        = number
}

variable "indy_client_ip" {
  description = "Client IP for the Indy Node."
  type        = string
}

variable "indy_client_port" {
  description = "Client port for the Indy Node."
  type        = number
}

variable "indy_network_name" {
  description = "Network name for the Indy Node."
  type        = string
}

variable "indy_node_name" {
  description = "Node name for the Indy Node."
  type        = string
}

variable "indy_controller_container_name" {
  description = "Indy Controller container name for the Indy Node's controller."
  type        = string
}

variable "indy_controller_image" {
  description = "Indy Controller image for the Indy Node's Controller"
  type        = string
}

variable "sock" {
  description = "host path to docker.sock"
  type        = string
}
###########################################################
# SCRIPTS 
###########################################################

variable "run_seed_script" {
  description = "Flag to determine if the seed script should run"
  type        = bool
  default     = false
}
