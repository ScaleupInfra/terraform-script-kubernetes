provider "kubernetes" {
    config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "scalable-nginx-test"
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
          image = "nginx:1.7.8"
          name  = "nginx app"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "200m"
              memory = "256Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "128Mi"
            }
          }
        }
      }
    }
  }
}