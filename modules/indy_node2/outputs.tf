output "indy_node2_container_id" {
  description = "The ID of the Indy Node container."
  value       = docker_container.indy_node2.id
}