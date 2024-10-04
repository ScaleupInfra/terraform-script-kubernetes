provider "kubernetes" {
    config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "scalable-nginx-app"
    labels = {
      App = "ScalableNginxApp"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableNginxApp"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginxApp"
        }
      }
      spec {
        container {
          image = "nginx:latest"
          name  = "nginx-app"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}