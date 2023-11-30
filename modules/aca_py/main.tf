resource "docker_container" "aries-cloud-agent" {
  command = [
    "start",
    "--auto-provision",
    "--arg-file=acapy-static-args.yml",
    "--inbound-transport", "http", "0.0.0.0", "8030",
    "--endpoint=http://host.docker.internal:8030",
    "--wallet-name='wallet_db'",
    "--wallet-key='changekey'",
    "--seed", "00000000000000000000000Endorser1",
    "--admin", "0.0.0.0", "8031",
    "--label='AGENT1'",
    "--admin-insecure-mode",
    "--tails-server-base-url=http://10.133.133.10:6543",
    "--tails-server-upload-url=http://10.133.133.10:6543"
  ]

  depends_on = [var.ledger_browser_id]

  image = var.aries_cloudagent_image
  name  = var.aries_cloudagent_name

  dynamic "ports" {
    for_each = var.aries_cloudagent_external_ports
    content {
      internal = ports.value
      external = ports.value
    }
  }

  networks_advanced {
    name         = var.docker_network_name
    ipv4_address = var.aries_cloudagent_ipv4_address
  }

  volumes {
    container_path = "/home/indy/acapy-static-args.yml"
    host_path      = abspath("${path.module}/${var.acapy_static_args_path}")
  }
  volumes {
    container_path = "/home/indy/genesis-transaction-list.yml"
    host_path      = abspath("${path.module}/${var.genesis_transaction_list_path}")
  }

}

# resource "docker_container" "postgres-wallet" {
#   image = var.postgres_wallet_image
#   name  = var.postgres_wallet_name

#   env = [
#     "POSTGRES_USER=${var.postgres_user}",
#     "POSTGRES_PASSWORD=${var.postgres_password}"
#   ]

#   networks_advanced {
#     name         = var.docker_network_name
#     ipv4_address = var.postgres_wallet_ipv4_address
#   }

#   ports {
#     internal = 5432
#     external = var.postgres_wallet_port
#   }

#   volumes {
#     container_path = "/var/lib/postgresql/data"
#     host_path      = abspath("${path.module}/${var.postgres_wallet_data_path}")
#   }

# }
