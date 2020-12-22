


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



```

resource "kubernetes_deployment" "tf-efs-provisioner" {

  depends_on = [
  kubernetes_storage_class.tf_efs_sc,
  kubernetes_namespace.tf-ns
  ]

  metadata {
    name = "tf-efs-provisioner"
    namespace = "terraform-prom-graf-namespace"
  }

  spec {
    replicas = 1
    strategy {
      type = "Recreate"
    }
    selector {
      match_labels = {
        app = "tf-efs"
      }
    }

    template {
      metadata {
        labels = {
          app = "tf-efs"
        }
      }

      spec {
        automount_service_account_token = true
        container {
          image = "quay.io/external_storage/efs-provisioner:v0.1.0"
          name  = "tf-efs-provision"
          env {
            name  = "FILE_SYSTEM_ID"
            value = data.aws_efs_file_system.tf-efs-fs.file_system_id
          }
          env {
            name  = "AWS_REGION"
            value = "us-east-1"
          }
          env {
            name  = "PROVISIONER_NAME"
            value = kubernetes_storage_class.tf_efs_sc.storage_provisioner
          }
          volume_mount {
            name       = "pv-volume"
            mount_path = "/persistentvolumes"
          }
        }
        volume {
          name = "pv-volume"
          nfs {
            server = data.aws_efs_file_system.tf-efs-fs.dns_name
            path   = "/"
          }
        }
      }
    }
  }
}


```
