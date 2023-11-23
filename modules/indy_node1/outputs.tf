output "indy_node1_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_node1.id
}

output "indy_controller_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_controller.id
}