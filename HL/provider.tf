terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.63.0"
    }
  }
  required_version = ">= 0.13"
}



####  AWS Provider 
provider "aws" {
  alias      = "region1"
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region     = "eu-west-1a"
  profile    = "ansible"
  
}


provider "aws" {
  alias      = "region2"
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region     = "eu-west-1b"
  profile    = "ansible"
}


provider "aws" {
  alias      = "region3"
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region     = "eu-west-1c"
  profile    = "ansible"
}

data "aws_availability_zones" "available" {}
