variable "container_name" {
  description = "Name for the Docker container."
  type        = string
}

variable "dockerfile_path" {
  description = "Path to the Dockerfile."
  type        = string
  default     = "/home/dev/workspace/fathom/careeronestop-py-service/"  # You can adjust the default path as needed
}

variable "external_port" {
  description = "External port for the Docker container."
  type        = number
}
