output "aries_cloudagent_container_id" {
  description = "The ID of the Aries Cloud Agent container"
  value       = docker_container.aries-cloud-agent.id
}
