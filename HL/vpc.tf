### Key ####

resource "aws_key_pair" "ec2loginkey" {
  key_name = "login-key"
  ## change here if you are using different key pair
  public_key = file(pathexpand(var.ssh_key_pair_pub))
}


###### VPC ######

resource "aws_vpc" "vpc" {
  name = "vpc"
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags {
    Name = "vpc"
  }
}











