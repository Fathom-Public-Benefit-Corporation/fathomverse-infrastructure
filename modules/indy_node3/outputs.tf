output "indy_node3_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_node3.id
}

output "indy_controller3_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_controller3.id
}