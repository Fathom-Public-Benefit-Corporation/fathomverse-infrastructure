#!/bin/bash

# Disconnect the Docker network
docker network disconnect fathomverse indy_node1_service
docker network disconnect fathomverse indy_node2_service
docker network disconnect fathomverse indy_node3_service
docker network disconnect fathomverse indy_node4_service
docker network disconnect fathomverse indy_controller1
docker network disconnect fathomverse indy_controller2
docker network disconnect fathomverse indy_controller3
docker network disconnect fathomverse indy_controller4

# Remove the network
docker network rm fathomverse