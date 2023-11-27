output "ledger_browser_container_id" {
  description = "The ID of the Ledger Browser container."
  value       = docker_container.ledger_browser.id
}
