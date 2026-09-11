output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  value = aws_instance.bastion.private_ip
}

output "prive_private_ip" {
  value = aws_instance.prive.private_ip
}

output "cle_path" {
  value = local_file.private_key.filename
}
