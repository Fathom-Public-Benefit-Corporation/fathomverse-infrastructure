indy_node_container_name       = "indy_node_service"
indy_node_image                = "ghcr.io/hyperledger/indy-node-container/indy_node:1.12.6-ubuntu18-main"
indy_node_external_ports       = [9701, 9702]
indy_node_ip                   = "0.0.0.0"
indy_node_port                 = 9701
indy_client_ip                 = "0.0.0.0"
indy_client_port               = 9702
indy_network_name              = "fathomverse"
indy_node_name                 = "USEastJohn"
indy_controller_container_name = "indy_node_controller"
indy_controller_image          = "ghcr.io/hyperledger/indy-node-container/indy_node_controller:1.2.3"

sock = "/var/run/docker.sock"
