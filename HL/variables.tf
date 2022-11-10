variable "aws_region" {
  description = "The AWS region to use"
  default     = "eu-central-1"
}


variable "vpn_username" {
  description = "Admin Username to access server"
  type        = string
  default     = "openvpn"
}

variable "vpn_password" {
  description = "Admin Password to access server"
  type        = string
  default     = "password"
}


variable "vpc_cidr_block" {
  description = "CIDR block for vpc"
}


variable "ssh_user" {
  default  = "ec2_user"
}
