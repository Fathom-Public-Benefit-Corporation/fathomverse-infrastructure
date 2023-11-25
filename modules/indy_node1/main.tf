data "local_file" "node_env" {
  filename = "${path.root}/.node1.env"
  count    = fileexists("${path.root}/.node1.env") ? 1 : 0
}

###########################################################
# INDY NODE 1
###########################################################
resource "docker_image" "indy_node1" {
  name         = var.indy_node_image
  keep_locally = false
}

resource "docker_container" "indy_node1" {
  depends_on = [data.local_file.node_env]

  image = docker_image.indy_node1.name
  name  = var.indy_node1_container_name

  env = concat(
    [
      length(data.local_file.node_env) > 0 ? trimspace(data.local_file.node_env[0].content) : "INDY_NODE_SEED=",
      "INDY_NODE_IP=${var.indy_node1_ip}",
      "INDY_NODE_PORT=${var.indy_node1_port}",
      "INDY_CLIENT_IP=${var.indy_node1_client_ip}",
      "INDY_CLIENT_PORT=${var.indy_node1_client_port}",
      "INDY_NETWORK_NAME=${var.indy_network_name}",
      "INDY_NODE_NAME=${var.indy_node1_name}",
      "CONTROLLER_CONTAINER_NAME=${var.indy_controller1_container_name}"
    ]
  )

  dynamic "ports" {
    for_each = var.indy_node1_external_ports
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
    name = var.indy_network_name
  }

  restart = "always"
}

###########################################################
# INDY CONTROLLER
###########################################################
resource "docker_image" "indy_controller1" {
  name         = var.indy_controller_image
  keep_locally = false
}

resource "docker_container" "indy_controller1" {
  depends_on = [docker_container.indy_node1]

  image = docker_image.indy_controller1.name
  name  = var.indy_controller1_container_name

  env = [
    "INDY_NETWORK_NAME=${var.indy_network_name}",
    "NODE_CONTAINER=${var.indy_node1_container_name}",
    "CONTROLLER_CONTAINER_NAME=${var.indy_controller1_container_name}"
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
    name = var.indy_network_name
  }

  init = true
}
