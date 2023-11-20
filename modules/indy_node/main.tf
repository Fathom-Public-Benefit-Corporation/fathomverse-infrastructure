data "local_file" "node_env" {
  filename = "${path.root}/.node.env"
  count    = fileexists("${path.root}/.node.env") ? 1 : 0
}

resource "docker_image" "indy_node" {
  name         = var.indy_node_image
  keep_locally = false
}

resource "docker_container" "indy_node" {
  depends_on = [data.local_file.node_env]
  
  image = docker_image.indy_node.name
  name  = var.container_name

  env = concat(
  [
    length(data.local_file.node_env) > 0 ? trimspace(data.local_file.node_env[0].content) : "INDY_NODE_SEED=",
    "INDY_NODE_IP=${var.indy_node_ip}",
    "INDY_NODE_PORT=${var.indy_node_port}",
    "INDY_CLIENT_IP=${var.indy_client_ip}",
    "INDY_CLIENT_PORT=${var.indy_client_port}",
    "INDY_NETWORK_NAME=${var.indy_network_name}",
    "INDY_NODE_NAME=${var.indy_node_name}",
    "CONTROLLER_CONTAINER_NAME=${var.controller_container_name}"
  ]
)


  dynamic "ports" {
    for_each = var.indy_node_external_ports
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

  restart = "always"
}
