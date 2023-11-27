variable "docker_network_name" {
  description = "Name of the Docker network"
  type        = string
  default     = "sandbox"
}

variable "indy_network_name" {
  description = "Network name for the Indy Node."
  type        = string
}

variable "indy_node_image" {
  description = "Docker image for the Indy Node."
  type        = string
}

###########################################################
# INDY NODE 1
###########################################################
variable "indy_node1_container_name" {
  description = "Name for the Indy Node Docker container."
  type        = string
}

variable "indy_node1_external_ports" {
  description = "List of external ports for the Docker container."
  type        = list(number)
}

variable "indy_node1_ip" {
  description = "IP address for the Indy Node."
  type        = string
}

variable "indy_node1_port" {
  description = "Node port for the Indy Node."
  type        = number
}

variable "indy_node1_client_ip" {
  description = "Client IP for the Indy Node."
  type        = string
}

variable "indy_node1_client_port" {
  description = "Client port for the Indy Node."
  type        = number
}

variable "indy_node1_name" {
  description = "Node name for the Indy Node."
  type        = string
}

###########################################################
# INDY CONTROLLER
###########################################################
variable "indy_controller1_container_name" {
  description = "Indy Controller container name for the Indy Node and Indy Controller"
  type        = string
}

variable "indy_controller_image" {
  description = "Docker image for Indy Controller"
  type        = string
}

variable "docker_sock_host_path" {
  description = "Docker socket path on host"
  type        = string
}
