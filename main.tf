terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

module "careeronestop" {
  source        = "./modules/careeronestop"
  container_name = var.container_name
  dockerfile_path = var.dockerfile_path
  external_port = var.external_port
}
