resource "null_resource" "manage_docker_network_script" {
  count = var.manage_docker_network_script ? 1 : 0

  depends_on = [
    module.indy_node1.indy_node1_container_id,
    module.indy_node2.indy_node2_container_id,
    module.indy_node3.indy_node3_container_id,
    module.indy_node4.indy_node4_container_id,
    module.indy_node1.indy_controller1_container_id,
    module.indy_node2.indy_controller2_container_id,
    module.indy_node3.indy_controller3_container_id,
    module.indy_node4.indy_controller4_container_id,
  ]

  provisioner "local-exec" {
    command = "bash ${path.root}/scripts/manage_docker_network.sh"
  }
}

resource "null_resource" "run_script" {
  count = var.run_seed_script ? 1 : 0

  provisioner "local-exec" {
    command = "bash ${path.root}/scripts/generate_random_seeds.sh"
  }
}
