output "indy_node2_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_node2.id
}

output "indy_controller2_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_controller2.id
}