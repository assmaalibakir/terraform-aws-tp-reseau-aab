module "network" {
  source      = "./modules/network"
  identifiant = var.identifiant
}

module "security" {
  source      = "./modules/security"
  identifiant = var.identifiant
  vpc_id      = module.network.vpc_id
  mon_ip      = "88.190.172.68"
}
