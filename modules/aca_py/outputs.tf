output "aries_cloudagent1_container_id" {
  description = "The ID of the Aries Cloud Agent container"
  value       = docker_container.aries-cloud-agent1.id
}

output "aries_cloudagent2_container_id" {
  description = "The ID of the Aries Cloud Agent container"
  value       = docker_container.aries-cloud-agent2.id
}
