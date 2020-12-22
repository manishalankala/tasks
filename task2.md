


Please provide Terraform code to deploy Prometheus server on AWS.

----------------------------------------------------------------------------------



1.versions.tf

2.providers.tf

3.storage_class.tf

4.storage_rbac.tf









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



storage_class.tf

```

resource "kubernetes_storage_class" "tf_efs_sc" {
  metadata {
    name = "tf-eks-sc"
  }
  storage_provisioner = "aws-efs/tf-eks-sc"
  reclaim_policy      = "Retain"
}

```


storage_rbac.tf

```
resource "kubernetes_cluster_role_binding" "tf_efs_role_binding" {
   depends_on = [
    kubernetes_namespace.tf-ns,
  ]
  metadata {
    name = "tf_efs_role_binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "terraform-prom-graf-namespace"
  }
}

```
