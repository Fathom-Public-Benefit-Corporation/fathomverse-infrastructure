output "indy_node4_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_node4.id
}

output "indy_controller4_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_controller4.id
}