output "ledger_browser_container_id" {
  description = "The ID of the Ledger Browser container."
  value       = docker_container.ledger_browser.id
}

output "ipv4_address" {
  value = [for net in docker_container.ledger_browser.networks_advanced: net.ipv4_address if net.name == "sandbox"][0]
}
