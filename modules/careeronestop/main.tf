resource "docker_image" "service_image" {
  name = "${var.container_name}:latest"
  build {
    path = var.dockerfile_path
  }
}

resource "docker_container" "service_container" {
  image = docker_image.service_image.name
  name  = var.container_name
  ports {
    internal = 5002
    external = var.external_port
  }
}

