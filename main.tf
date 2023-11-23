terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

module "indy" {
  source                         = "./modules/indy"
  indy_node_container_name       = var.indy_node_container_name
  indy_node_image                = var.indy_node_image
  indy_node_external_ports       = var.indy_node_external_ports
  indy_node_ip                   = var.indy_node_ip
  indy_node_port                 = var.indy_node_port
  indy_client_ip                 = var.indy_client_ip
  indy_client_port               = var.indy_client_port
  indy_network_name              = var.indy_network_name
  indy_node_name                 = var.indy_node_name
  indy_controller_container_name = var.indy_controller_container_name
  indy_controller_image          = var.indy_controller_image
  docker_sock_host_path          = var.sock
}
