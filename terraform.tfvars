careeronestop_container_name = "careeronestop_service"
careeronestop_dockerfile_path = "/home/dev/workspace/fathom/careeronestop-py-service/"
careeronestop_external_port = 5002

indy_node_container_name = "indy_node_service"
indy_node_image = "ghcr.io/hyperledger/indy-node-container/indy_node:1.12.6-ubuntu18-main"
indy_node_external_ports = [9701, 9702]
indy_node_ip = "0.0.0.0"
indy_node_port = 9701
indy_client_ip = "0.0.0.0"
indy_client_port = 9702
indy_network_name = "fathomverse"
indy_node_name = "USEastJohn"
controller_container_name = "indy_node_controller"
