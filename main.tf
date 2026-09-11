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

module "compute" {
  source             = "./modules/compute"
  identifiant        = var.identifiant
  public_subnet_id   = module.network.public_subnet_id
  private_subnet_id  = module.network.private_subnet_id
  bastion_sg_id      = module.security.bastion_sg_id
  prive_sg_id        = module.security.prive_sg_id
}
