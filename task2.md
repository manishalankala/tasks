


Please provide Terraform code to deploy Prometheus server on AWS.

----------------------------------------------------------------------------------




versions.tf

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.15"
    }
  }
  required_version = ">= 0.13"
}

```

providers.tf

```
provider "aws" {
  profile = "root"
  region  = "us-east-1"
}

provider "kubernetes" {}

data "aws_availability_zones" "available" {}

resource "kubernetes_namespace" "tf-ns" {
  metadata {
    name = "terraform-prom-graf-namespace"
  }
  
}

data "aws_efs_file_system" "tf-efs-fs" {
  creation_token = "my-efs-file-system-1"
}



```
