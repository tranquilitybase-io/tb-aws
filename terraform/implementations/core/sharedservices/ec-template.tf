resource "kubernetes_deployment" "aws_lz_k8s_deployment_eagleconsole" {
  metadata {
    name = "eagleconsole-v1"
  }

  spec {
    replicas = 1

    template {
      metadata {
        labels = {
          app = "eagleconsole"

          version = "v1"
        }
      }

      spec {
        container {
          name  = "eagleconsole"
          image = "gcr.io/tranquility-base-images/tb-eagle-console:landingzone"

          port {
            container_port = 80
          }

          resources {
            requests {
              cpu = "100m"
            }
          }

          image_pull_policy = "IfNotPresent"
        }
      }
    }
  }

  provider = kubernetes.network
}

resource "kubernetes_service" "aws_lz_k8s_service_eagleconsole" {
  metadata {
    name = "eagleconsole"

    labels = {
      app = "eagleconsole"
    }
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = "4200"
    }

    port {
      name        = "https"
      port        = 443
      target_port = "4200"
    }

    selector = {
      app = "eagleconsole"
    }
  }
  provider = kubernetes.network
}


resource "kubernetes_deployment" "aws_lz_k8s_deployment_houstonsrv" {
  metadata {
    name = "houstonservice-v1"
  }

  spec {
    replicas = 1

    template {
      metadata {
        labels = {
          app = "houstonservice"

          version = "v1"
        }
      }

      spec {
        container {
          name  = "houstonservice"
          image = "gcr.io/tranquility-base-images/tb-houston-service:landingzone"

          port {
            container_port = 80
          }

          env {
            name  = "GOOGLE_APPLICATION_CREDENTIALS"
            value = "/var/secrets/google/ec-service-account-config.json"
          }

          env {
            name  = "SQLALCHEMY_DATABASE_URI"
            value = "mysql+mysqlconnector://eagle-user:eagle-user-secret-pw@mysql57/eagle_db"
          }

          env {
            name  = "SQLALCHEMY_ECHO"
            value = "True"
          }

          env {
            name  = "SQLALCHEMY_TRACK_MODIFICATIONS"
            value = "True"
          }

          resources {
            requests {
              cpu = "100m"
            }
          }

          image_pull_policy = "IfNotPresent"
        }
      }
    }
  }
  provider = kubernetes.network
}

resource "kubernetes_service" "aws_lz_k8s_service_houstonsrv" {
  metadata {
    name = "houstonservice"

    labels = {
      app = "houstonservice"
    }
  }

  spec {
    port {
      name        = "http"
      port        = 80
      target_port = "3000"
    }

    port {
      name        = "https"
      port        = 443
      target_port = "3000"
    }

    selector = {
      app = "houstonservice"
    }
  }
  provider = kubernetes.network
}


resource "kubernetes_deployment" "aws_lz_k8s_deployment_mysql" {
  metadata {
    name = "mysql57"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mysql57"
      }
    }

    template {
      metadata {
        labels = {
          app = "mysql57"
        }
      }

      spec {
        container {
          name  = "mysql57"
          image = "gcr.io/tranquility-base-images/tb-houston-mysql57:landingzone"

          port {
            name           = "mysql57"
            container_port = 3306
          }

          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = "my-secret-pw"
          }

          env {
            name  = "MYSQL_USER"
            value = "eagle-user"
          }

          env {
            name  = "MYSQL_PASSWORD"
            value = "eagle-user-secret-pw"
          }

          env {
            name  = "MYSQL_DATABASE"
            value = "eagle_db"
          }

          resources {
            requests {
              cpu = "100m"
            }
          }

          image_pull_policy = "IfNotPresent"
        }
      }
    }

    strategy {
      type = "Recreate"
    }
  }

  provider = kubernetes.network
}



resource "kubernetes_service" "aws_lz_k8s_service_mysql" {
  metadata {
    name = "mysql57"
  }

  spec {
    port {
      port        = 3306
      target_port = "3306"
    }

    selector = {
      app = "mysql57"
    }

    cluster_ip = "None"
  }
  provider = kubernetes.network
}
