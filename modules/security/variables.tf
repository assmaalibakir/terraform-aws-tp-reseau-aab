variable "identifiant" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "mon_ip" {
  description = "Adresse IP publique du poste, en notation /32"
  type        = string
}
