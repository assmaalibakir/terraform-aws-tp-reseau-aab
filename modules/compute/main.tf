# Recherche de l'AMI Amazon Linux la plus recente
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Generation de la paire de cles SSH (ED25519)
resource "tls_private_key" "bastion" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "bastion" {
  key_name   = "tp-${var.identifiant}-cle"
  public_key = tls_private_key.bastion.public_key_openssh
}

# Sauvegarde de la cle privee en local (jamais sur le bastion)
resource "local_file" "private_key" {
  content         = tls_private_key.bastion.private_key_openssh
  filename        = "${path.root}/tp-${var.identifiant}-cle.pem"
  file_permission = "0400"
}

# Instance bastion, dans le sous-reseau public
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.bastion_sg_id]
  key_name                    = aws_key_pair.bastion.key_name
  associate_public_ip_address = true

  tags = {
    Name = "tp-${var.identifiant}-bastion"
  }
}

# Instance privee, sans adresse publique
resource "aws_instance" "prive" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.prive_sg_id]
  key_name               = aws_key_pair.bastion.key_name

  tags = {
    Name = "tp-${var.identifiant}-app"
  }
}
