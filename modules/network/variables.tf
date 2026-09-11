variable "identifiant" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.11.0/24"
}

variable "availability_zone" {
  type    = string
  default = "eu-west-2a"
}
