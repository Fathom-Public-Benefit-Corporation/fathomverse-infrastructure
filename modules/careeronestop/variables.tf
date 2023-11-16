variable "container_name" {
  description = "Name for the Docker container."
  type        = string
}

variable "dockerfile_path" {
  description = "Path to the Dockerfile."
  type        = string
}

variable "external_port" {
  description = "External port for the Docker container."
  type        = number
}
