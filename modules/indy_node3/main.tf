data "local_file" "node_env" {
  filename = "${path.root}/.node3.env"
  count    = fileexists("${path.root}/.node3.env") ? 1 : 0
}

###########################################################
# INDY NODE 3
###########################################################
resource "docker_image" "indy_node3" {
  name         = var.indy_node_image
  keep_locally = false
}

resource "docker_container" "indy_node3" {
  depends_on = [data.local_file.node_env]

  image = docker_image.indy_node3.name
  name  = var.indy_node3_container_name

  env = concat(
    [
      length(data.local_file.node_env) > 0 ? trimspace(data.local_file.node_env[0].content) : "INDY_NODE_SEED=",
      "INDY_NODE_IP=${var.indy_node3_ip}",
      "INDY_NODE_PORT=${var.indy_node3_port}",
      "INDY_CLIENT_IP=${var.indy_node3_client_ip}",
      "INDY_CLIENT_PORT=${var.indy_node3_client_port}",
      "INDY_NETWORK_NAME=${var.indy_network_name}",
      "INDY_NODE_NAME=${var.indy_node3_name}",
      "CONTROLLER_CONTAINER_NAME=${var.indy_controller3_container_name}"
    ]
  )

  dynamic "ports" {
    for_each = var.indy_node3_external_ports
    content {
      internal = ports.value
      external = ports.value
    }
  }

  volumes {
    container_path = "/etc/indy"
    host_path      = abspath("${path.module}/etc_indy")
  }
  volumes {
    container_path = "/var/lib/indy"
    host_path      = abspath("${path.module}/lib_indy")
  }
  volumes {
    container_path = "/var/log/indy"
    host_path      = abspath("${path.module}/log_indy")
  }

  networks_advanced {
    name = var.docker_network_name
    ipv4_address = "10.133.133.3"
  }

  restart = "always"
}

###########################################################
# INDY CONTROLLER
###########################################################
resource "docker_image" "indy_controller3" {
  name         = var.indy_controller_image
  keep_locally = false
}

resource "docker_container" "indy_controller3" {
  depends_on = [docker_container.indy_node3]

  image = docker_image.indy_controller3.name
  name  = var.indy_controller3_container_name

  env = [
    "INDY_NETWORK_NAME=${var.indy_network_name}",
    "NODE_CONTAINER=${var.indy_node3_container_name}",
    "CONTROLLER_CONTAINER_NAME=${var.indy_controller3_container_name}"
  ]

  volumes {
    container_path = "/etc/indy"
    host_path      = abspath("${path.module}/etc_indy")
  }

  volumes {
    container_path = "/var/run/docker.sock"
    host_path      = var.docker_sock_host_path
  }

  networks_advanced {
    name = var.docker_network_name
    ipv4_address = "10.133.133.7"
  }

  init = true
}
