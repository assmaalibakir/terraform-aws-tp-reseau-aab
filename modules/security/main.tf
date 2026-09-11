resource "aws_security_group" "bastion" {
  name        = "tp-${var.identifiant}-sg-bastion"
  description = "Acces SSH depuis le poste du stagiaire"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH depuis mon poste"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.mon_ip}/32"]
  }

  egress {
    description = "Tout le trafic sortant"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tp-${var.identifiant}-sg-bastion"
  }
}

resource "aws_security_group" "prive" {
  name        = "tp-${var.identifiant}-sg-prive"
  description = "Acces SSH uniquement depuis le bastion"
  vpc_id      = var.vpc_id

  ingress {
    description     = "SSH depuis le bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  egress {
    description = "Tout le trafic sortant"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tp-${var.identifiant}-sg-prive"
  }
}
