terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

resource "docker_network" "sandbox_network" {
  name = "sandbox"
  ipam_config {
    subnet  = "10.133.133.0/24"
    gateway = "10.133.133.254"
  }
}

module "indy_node1" {
  source            = "./modules/indy_node1"
  indy_network_name = var.indy_network_name
  indy_node_image   = var.indy_node_image

  indy_node1_container_name = var.indy_node1_container_name
  indy_node1_external_ports = var.indy_node1_external_ports
  indy_node1_ip             = var.indy_node1_ip
  indy_node1_port           = var.indy_node1_port
  indy_node1_client_ip      = var.indy_node1_client_ip
  indy_node1_client_port    = var.indy_node1_client_port
  indy_node1_name           = var.indy_node1_name

  indy_controller1_container_name = var.indy_controller1_container_name
  indy_controller_image           = var.indy_controller_image
  docker_sock_host_path           = var.sock
}

module "indy_node2" {
  source            = "./modules/indy_node2"
  indy_network_name = var.indy_network_name
  indy_node_image   = var.indy_node_image

  indy_node2_container_name = var.indy_node2_container_name
  indy_node2_external_ports = var.indy_node2_external_ports
  indy_node2_ip             = var.indy_node2_ip
  indy_node2_port           = var.indy_node2_port
  indy_node2_client_ip      = var.indy_node2_client_ip
  indy_node2_client_port    = var.indy_node2_client_port
  indy_node2_name           = var.indy_node2_name

  indy_controller2_container_name = var.indy_controller2_container_name
  indy_controller_image           = var.indy_controller_image
  docker_sock_host_path           = var.sock
}

module "indy_node3" {
  source            = "./modules/indy_node3"
  indy_network_name = var.indy_network_name
  indy_node_image   = var.indy_node_image

  indy_node3_container_name = var.indy_node3_container_name
  indy_node3_external_ports = var.indy_node3_external_ports
  indy_node3_ip             = var.indy_node3_ip
  indy_node3_port           = var.indy_node3_port
  indy_node3_client_ip      = var.indy_node3_client_ip
  indy_node3_client_port    = var.indy_node3_client_port
  indy_node3_name           = var.indy_node3_name

  indy_controller3_container_name = var.indy_controller3_container_name
  indy_controller_image           = var.indy_controller_image
  docker_sock_host_path           = var.sock
}

module "indy_node4" {
  source            = "./modules/indy_node4"
  indy_network_name = var.indy_network_name
  indy_node_image   = var.indy_node_image

  indy_node4_container_name = var.indy_node4_container_name
  indy_node4_external_ports = var.indy_node4_external_ports
  indy_node4_ip             = var.indy_node4_ip
  indy_node4_port           = var.indy_node4_port
  indy_node4_client_ip      = var.indy_node4_client_ip
  indy_node4_client_port    = var.indy_node4_client_port
  indy_node4_name           = var.indy_node4_name

  indy_controller4_container_name = var.indy_controller4_container_name
  indy_controller_image           = var.indy_controller_image
  docker_sock_host_path           = var.sock
}

module "ledger_browser" {
  source = "./modules/ledger_browser"

  web_server_host_port = "9000"
}

module "tails_server" {
  source = "./modules/tails_server"

  genesis_url = "http://${module.ledger_browser.ipv4_address}:9000/genesis"
}
