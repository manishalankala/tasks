
# Task 2



Please provide Terraform code to deploy Prometheus server on AWS.

----------------------------------------------------------------------------------



1.versions.tf

2.providers.tf

3.storage_class.tf

4.storage_rbac.tf

5.efs_provision.tf

6.prometheusk8s.tf

7.deployment.yaml (prometheus)

8.service.yaml (prometheus)

9.deployment.yaml (prometheus)

10.service.yaml (prometheus)







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



efs_provision.tf

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




prometheusk8s.tf

```

provider "kubernetes" {}

# pvc
resource "kubernetes_persistent_volume_claim" "prom_pvc" {
  metadata {
    name = "tf-prometheus-pvc"
    annotations = {
      "volume.beta.kubernetes.io/storage-class" = "tf-eks-sc"
    }
    namespace = "terraform-prom-graf-namespace"
    labels = {
      vol = "prom_store_pvc"
    }
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "20Gi"
      }
    }
  }
}

#configMap 
resource "kubernetes_config_map" "prom_configmap" {
  depends_on = [
    kubernetes_persistent_volume_claim.prom_pvc,
  ]
  metadata {
    name      = "tf-prometheus-configmap"
    namespace =  "terraform-prom-graf-namespace"
  }

data = {
    "prometheus.yml" = <<EOF
    global:
      scrape_interval:     15s 
      evaluation_interval: 15s 
      
    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
        - targets: ['localhost:9090']
      - job_name: 'node1'
        static_configs:
        - targets: ['192.169.0.101:9100']
      - job_name: 'apache'
        static_configs:
        - targets: ['192.169.99.101:9117']
      - job_name: 'kube-state-metrics'
        static_configs:
        - targets: ['kube-state-metrics.kube-system.svc.cluster.local:8080']
EOF
  }
}

#deployment
resource "kubernetes_deployment" "prom_deploy" {
depends_on = [
    kubernetes_config_map.prom_configmap,
  ]
  metadata {
    name = "tf-prometheus-deployment"
    namespace =  "terraform-prom-graf-namespace"
    labels = {
      env = "metrics"
    }
  }

  spec {
    selector {
      match_labels = {
        env = "metrics"
      }
    }

    template {
      metadata {
        labels = {
          env = "metrics"
        }
      }

      spec {
        container {
          image = "dakshjain09/prometheus:v1"
          name  = "prom"
          args  = [ "--config.file=/prometheus.yml" ]
          port {
              container_port = 9090
              }
          volume_mount {
               name = "prometheus-persistent-storage-store"
               mount_path = "prometheus_data/"
             }
          volume_mount {
              name = "prometheus-script"
              mount_path = "/prometheus.yml"
              sub_path = "prometheus.yml"  
               }

        }
       volume {
          name = "prometheus-script"
          config_map {
            name = "tf-prometheus-configmap"
          }
        }
       volume {
          name = "prometheus-persistent-storage-store"
          persistent_volume_claim {
             claim_name = "tf-prometheus-pvc"
          }
        }
      }
    }
  }
}

# service 
resource "kubernetes_service" "prom_svc" {
depends_on = [
    kubernetes_deployment.prom_deploy,
  ]
  metadata {
    name = "tf-prometheus-svc"
    namespace =  "terraform-prom-graf-namespace"
  }
  spec {
    selector = {
      env = "${kubernetes_deployment.prom_deploy.metadata.0.labels.env}"
    }
    port {
      port        = 9090
      target_port = 9090
      node_port = 31003
    }
    type = "LoadBalancer"
  }
}





```





deployment.yaml

```

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/name: kube-state-metrics
    app.kubernetes.io/version: v1.8.0
  name: kube-state-metrics
  namespace: kube-system
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: kube-state-metrics
  template:
    metadata:
      labels:
        app.kubernetes.io/name: kube-state-metrics
        app.kubernetes.io/version: v1.8.0
    spec:
      containers:
      - image: quay.io/coreos/kube-state-metrics:v1.8.0
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8080
          initialDelaySeconds: 5
          timeoutSeconds: 5
        name: kube-state-metrics
        ports:
        - containerPort: 8080
          name: http-metrics
        - containerPort: 8081
          name: telemetry
        readinessProbe:
          httpGet:
            path: /
            port: 8081
          initialDelaySeconds: 5
          timeoutSeconds: 5
      nodeSelector:
        kubernetes.io/os: linux
      serviceAccountName: kube-state-metrics





```


```
  
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/name: kube-state-metrics
    app.kubernetes.io/version: v1.8.0
  name: kube-state-metrics
  namespace: kube-system
spec:
  clusterIP: None
  ports:
  - name: http-metrics
    port: 8080
    targetPort: http-metrics
  - name: telemetry
    port: 8081
    targetPort: telemetry
  selector:
    app.kubernetes.io/name: kube-state-metrics






```








service.yaml

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
  namespace: ingress-nginx
spec:
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  template:
    spec:
      containers:
        - image: grafana/grafana
          name: grafana
          ports:
            - containerPort: 3000
              protocol: TCP
          resources:
            limits:
              cpu: 500m
              memory: 2500Mi
            requests:
              cpu: 100m
              memory: 100Mi
          volumeMounts:
            - mountPath: /var/lib/grafana
              name: data
      restartPolicy: Always
      volumes:
        - emptyDir: {}
          name: data



```


service.yaml

```
apiVersion: v1
kind: Service
metadata:
  name: grafana
spec:
  ports:
    - port: 3000
      protocol: TCP
      targetPort: 3000
  type: NodePort



```
