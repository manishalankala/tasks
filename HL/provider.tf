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
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region     = "eu-west-1a"
  profile    = "ansible"
  alias      = "region1"
}


provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region     = "eu-west-1b"
  profile    = "ansible"
  alias      = "region2"
}


provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region     = "eu-west-1c"
  profile    = "ansible"
  alias      = "region3"
}

data "aws_availability_zones" "available" {}
