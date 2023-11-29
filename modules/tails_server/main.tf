resource "docker_container" "tails_server" {
  image   = "ghcr.io/bcgov/tails-server:latest"
  name    = "tails-server"
  command = ["tails-server", "--host", "0.0.0.0", "--port", "6543", "--storage-path=/tmp/tails-files", "--log-level=INFO"]
  env = [
    "GENESIS_URL=${var.genesis_url}",
    "STORAGE_PATH=/tmp/tails-files",
    "LOG_LEVEL=INFO",
    "TAILS_SERVER_URL=http://${var.ipv4_address}:6543"
  ]

  networks_advanced {
    name         = var.docker_network_name
    ipv4_address = var.ipv4_address
  }

  ports {
    internal = 6543
    external = 6543
  }

  volumes {
    host_path = abspath("${path.module}/tails-files")
    container_path = "/tmp/tails-files"
  }
}
