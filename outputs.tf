output "bastion_public_ip" {
  value = module.compute.bastion_public_ip
}

output "bastion_private_ip" {
  value = module.compute.bastion_private_ip
}

output "prive_private_ip" {
  value = module.compute.prive_private_ip
}

output "cle_path" {
  value = module.compute.cle_path
}
