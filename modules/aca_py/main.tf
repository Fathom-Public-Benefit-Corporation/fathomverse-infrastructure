resource "docker_container" "aries-cloud-agent1" {
  command = [
    "start",
    "--admin", "0.0.0.0", "8031",
    "--admin-insecure-mode",
    "--arg-file", "/home/indy/acapy-static-args.yml",
    "--auto-create-revocation-transactions",
    "--auto-promote-author-did",
    "--auto-provision",
    "--auto-request-endorsement",
    "--auto-write-transactions",
    "--inbound-transport", "http", "0.0.0.0", "8030",
    "--endorser-protocol-role", "author",
    "--endorser-public-did", "JJ5mHotESZ9a2W88tLB3FE",
    "--endpoint=http://${var.aries_cloudagent1_ipv4_address}:8030",
    "--label", "Agent-1",
    "--seed", "00000000000000000000000Endorser1",
    "--tails-server-base-url=http://10.133.133.10:6543",
    "--tails-server-upload-url=http://10.133.133.10:6543",
    "--wallet-name", "wallet_db",
    "--wallet-key", "changekey",
    "--wallet-type", "askar"
  ]

  depends_on = [var.ledger_browser_id]

  image = var.aries_cloudagent_image
  name  = var.aries_cloudagent1_name

  dynamic "ports" {
    for_each = var.aries_cloudagent1_external_ports
    content {
      internal = ports.value
      external = ports.value
    }
  }

  networks_advanced {
    name         = var.docker_network_name
    ipv4_address = var.aries_cloudagent1_ipv4_address
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

resource "docker_container" "aries-cloud-agent2" {
  command = [
    "start",
    "--admin", "0.0.0.0", "8033",
    "--admin-insecure-mode",
    "--auto-endorse-transactions",
    "--auto-provision",
    "--arg-file", "/home/indy/acapy-static-args.yml",
    "--endorser-protocol-role", "endorser",
    "--endpoint=http://${var.aries_cloudagent2_ipv4_address}:8032",
    "--inbound-transport", "http", "0.0.0.0", "8032",
    "--label", "Agent-2",
    "--open-mediation",
    "--seed", "00000000000000000000000Endorser2",
    "--tails-server-base-url=http://10.133.133.10:6543",
    "--tails-server-upload-url=http://10.133.133.10:6543",
    "--wallet-name", "wallet_db",
    "--wallet-key", "changekey",
    "--wallet-type", "askar"
  ]

  depends_on = [var.ledger_browser_id]

  image = var.aries_cloudagent_image
  name  = var.aries_cloudagent2_name

  dynamic "ports" {
    for_each = var.aries_cloudagent2_external_ports
    content {
      internal = ports.value
      external = ports.value
    }
  }

  networks_advanced {
    name         = var.docker_network_name
    ipv4_address = var.aries_cloudagent2_ipv4_address
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
