output "indy_node_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_node.id
}

output "indy_controller_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_controller.id
}
