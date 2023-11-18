resource "null_resource" "run_script" {
  count = var.run_seed_script ? 1 : 0

  provisioner "local-exec" {
    command = "bash ${path.root}/scripts/generate_random_seeds.sh"
  }
}
