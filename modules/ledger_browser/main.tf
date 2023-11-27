resource "docker_container" "ledger_browser" {
  image   = "ghcr.io/bcgov/von-network-base:latest"
  name    = "ledger-browser"
  init    = true
  command = ["bash", "-c", "sleep 10; ./scripts/start_webserver.sh;"]

  env = {
    GENESIS_FILE         = "/var/lib/indy/${var.indy_network_name}/pool_transactions_genesis"
    MAX_FETCH            = "50000"
    RESYNC_TIME          = "120"
    REGISTER_NEW_DIDS    = "True"
    LEDGER_INSTANCE_NAME = "Sandbox"
    WEB_ANALYTICS_SCRIPT = ""
    INFO_SITE_TEXT       = "IaC built by John Marquez @ Github"
    INFO_SITE_URL        = "https://github.com/jmarquez-cs/hyperledger-indy-infrastructure"
    LEDGER_SEED          = "000000000000000000000000Steward1"
  }

  networks_advanced {
    name         = var.network_name
    ipv4_address = var.ipv4_address
  }

  ports {
    internal = 8000
    external = var.web_server_host_port
  }

  volumes {
    container_path = "/etc/indy"
    host_path      = abspath("${path.module}/etc_indy")
  }
  volumes {
    container_path = "/var/lib/indy"
    host_path      = abspath("${path.module}/lib_indy")
  }

}
