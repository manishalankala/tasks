


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
