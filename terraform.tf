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

resource "kubernetes_deployment" "homework" {
  metadata {
    name = "homework-deployment"
    labels = {
      app = "homework"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "homework"
      }
    }

    template {
      metadata {
        labels = {
          app = "homework"
        }
      }

      spec {
        container {
          name  = "homework"
          image = "ghcr.io/lukacsi/homework:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "homework" {
  metadata {
    name = "homework-service"
  }

  spec {
    type = "NodePort"
    selector = {
      app = "homework"
    }

    port {
      port = 80
      target_port = 80
      protocol = "TCP"
      node_port = 30080
    }
  }
}

