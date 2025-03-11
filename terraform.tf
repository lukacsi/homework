terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "hello_world" {
  metadata {
    name = "hello-world-deployment"
    labels = {
      app = "hello-world"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "hello-world"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-world"
        }
      }

      spec {
        container {
          name  = "hello-world"
          image = "ghcr.io/lukacsi/homework:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello_world" {
  metadata {
    name = "hello-world-service"
  }

  spec {
    type = "NodePort"
    selector = {
      app = "hello-world"
    }

    port {
      port = 80
      target_port = 80
      protocol = "TCP"
      node_port = 30080
    }
  }
}

