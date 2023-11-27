variable "indy_network_name" {
  description = "Network name for the Indy Node."
  type        = string
}

variable "indy_node_image" {
  description = "Docker image for the Indy Node."
  type        = string
  default     = "ghcr.io/hyperledger/indy-node-container/indy_node:1.12.6-ubuntu18-main"
}

###########################################################
# INDY NODE 1
###########################################################
variable "indy_node1_container_name" {
  description = "Name for the Docker container."
  type        = string
}

variable "indy_node1_external_ports" {
  description = "External ports for the Docker container."
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
  description = "Client IP for the Indy Node1."
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
# INDY NODE 2
###########################################################
variable "indy_node2_container_name" {
  description = "Name for the Docker container."
  type        = string
}

variable "indy_node2_external_ports" {
  description = "External ports for the Docker container."
  type        = list(number)
}

variable "indy_node2_ip" {
  description = "IP address for the Indy Node."
  type        = string
}

variable "indy_node2_port" {
  description = "Node port for the Indy Node."
  type        = number
}

variable "indy_node2_client_ip" {
  description = "Client IP for the Indy Node1."
  type        = string
}

variable "indy_node2_client_port" {
  description = "Client port for the Indy Node."
  type        = number
}

variable "indy_node2_name" {
  description = "Node name for the Indy Node."
  type        = string
}

###########################################################
# INDY NODE 3
###########################################################
variable "indy_node3_container_name" {
  description = "Name for the Docker container."
  type        = string
}

variable "indy_node3_external_ports" {
  description = "External ports for the Docker container."
  type        = list(number)
}

variable "indy_node3_ip" {
  description = "IP address for the Indy Node."
  type        = string
}

variable "indy_node3_port" {
  description = "Node port for the Indy Node."
  type        = number
}

variable "indy_node3_client_ip" {
  description = "Client IP for the Indy Node1."
  type        = string
}

variable "indy_node3_client_port" {
  description = "Client port for the Indy Node."
  type        = number
}

variable "indy_node3_name" {
  description = "Node name for the Indy Node."
  type        = string
}

###########################################################
# INDY NODE 4
###########################################################
variable "indy_node4_container_name" {
  description = "Name for the Docker container."
  type        = string
}

variable "indy_node4_external_ports" {
  description = "External ports for the Docker container."
  type        = list(number)
}

variable "indy_node4_ip" {
  description = "IP address for the Indy Node."
  type        = string
}

variable "indy_node4_port" {
  description = "Node port for the Indy Node."
  type        = number
}

variable "indy_node4_client_ip" {
  description = "Client IP for the Indy Node1."
  type        = string
}

variable "indy_node4_client_port" {
  description = "Client port for the Indy Node."
  type        = number
}

variable "indy_node4_name" {
  description = "Node name for the Indy Node."
  type        = string
}

###########################################################
# INDY NODE CONTROLLERS
###########################################################
variable "indy_controller1_container_name" {
  description = "Indy Controller container name for the Indy Node's controller."
  type        = string
}

variable "indy_controller2_container_name" {
  description = "Indy Controller container name for the Indy Node's controller."
  type        = string
}

variable "indy_controller3_container_name" {
  description = "Indy Controller container name for the Indy Node's controller."
  type        = string
}

variable "indy_controller4_container_name" {
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
