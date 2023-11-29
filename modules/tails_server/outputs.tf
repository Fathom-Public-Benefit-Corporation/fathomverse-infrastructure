output "tails_server_container_id" {
  description = "The ID of the Ledger Browser container."
  value       = docker_container.tails_server.id
}
