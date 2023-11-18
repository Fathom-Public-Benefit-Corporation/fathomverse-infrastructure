###########################################################
# CAREERONESTOP 
###########################################################
variable "careeronestop_container_name" {
  description = "Name for the Docker container."
  type        = string
}

variable "careeronestop_dockerfile_path" {
  description = "Path to the Dockerfile."
  type        = string
  default     = "/home/dev/workspace/fathom/careeronestop-py-service/"  # You can adjust the default path as needed
}

variable "careeronestop_external_port" {
  description = "External port for the Docker container."
  type        = number
}
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

variable "controller_container_name" {
  description = "Controller container name for the Indy Node."
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
