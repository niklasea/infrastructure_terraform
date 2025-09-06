provider "hcloud" {
  token = var.hcloud_token
}

module "hetzner_server" {
  source = "./modules/terraform_hcloud_server"

  server_name = "kubernetes"
  datacenter  = "fsn1-dc14"
}
