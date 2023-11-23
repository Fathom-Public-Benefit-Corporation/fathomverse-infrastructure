indy_network_name = "fathomverse"
indy_node_image   = "ghcr.io/hyperledger/indy-node-container/indy_node:1.12.6-ubuntu18-main"

indy_node1_container_name = "indy_node1_service"
indy_node1_external_ports = [9701, 9702]
indy_node1_ip             = "0.0.0.0"
indy_node1_port           = 9701
indy_node1_client_ip      = "0.0.0.0"
indy_node1_client_port    = 9702
indy_node1_name           = "Steward1"

indy_node2_container_name = "indy_node2_service"
indy_node2_external_ports = [9703, 9704]
indy_node2_ip             = "0.0.0.0"
indy_node2_port           = 9703
indy_node2_client_ip      = "0.0.0.0"
indy_node2_client_port    = 9704
indy_node2_name           = "Steward2"

indy_node3_container_name = "indy_node3_service"
indy_node3_external_ports = [9705, 9706]
indy_node3_ip             = "0.0.0.0"
indy_node3_port           = 9705
indy_node3_client_ip      = "0.0.0.0"
indy_node3_client_port    = 9706
indy_node3_name           = "Steward3"

indy_node4_container_name = "indy_node4_service"
indy_node4_external_ports = [9707, 9708]
indy_node4_ip             = "0.0.0.0"
indy_node4_port           = 9707
indy_node4_client_ip      = "0.0.0.0"
indy_node4_client_port    = 9708
indy_node4_name           = "Steward4"

indy_controller_container_name = "indy_node_controller"
indy_controller_image          = "ghcr.io/hyperledger/indy-node-container/indy_node_controller:1.2.3"
sock                           = "/var/run/docker.sock"
