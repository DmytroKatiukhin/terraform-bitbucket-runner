resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "var.runner_namespace"
  }
}

resource "kubernetes_secret" "runner_oauth_credentials" {
  metadata {
    name = var.oauth_credentials_name
    labels = {
      accountUuid    = var.account_uuid
      repositoryUuid = var.repository_uuid
      runnerUuid     = var.runner_uuid
    }
  }

  data = {
    oauthClientId     = var.oauth_client_id
    oauthClientSecret = var.oauth_client_secret
  }
}

resource "kubernetes_job" "runner" {
  metadata {
    name = var.runner_name
  }

  spec {
    template {
      metadata {
        labels = {
          accountUuid    = var.account_uuid
          repositoryUuid = var.repository_uuid
          runnerUuid     = var.runner_uuid
        }
      }

      spec {
        volume {
          name = "tmp"
        }

        volume {
          name = "docker-containers"
        }

        volume {
          name = "var-run"
        }

        container {
          name  = "runner"
          image = var.runner_image

          env {
            name  = "ACCOUNT_UUID"
            value = "{${var.repository_uuid}}"
          }

          env {
            name  = "REPOSITORY_UUID"
            value = "{${var.repository_uuid}}"
          }

          env {
            name  = "RUNNER_UUID"
            value = "{${var.runner_uuid}}"
          }

          env {
            name = "OAUTH_CLIENT_ID"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.runner_oauth_credentials.metadata[0].name
                key  = "oauthClientId"
              }
            }
          }

          env {
            name = "OAUTH_CLIENT_SECRET"

            value_from {
              secret_key_ref {
                name = kubernetes_secret.runner_oauth_credentials.metadata[0].name
                key  = "oauthClientSecret"
              }
            }
          }

          env {
            name  = "WORKING_DIRECTORY"
            value = var.working_directory
          }

          volume_mount {
            name       = "tmp"
            mount_path = "/tmp"
          }

          volume_mount {
            name       = "docker-containers"
            read_only  = true
            mount_path = "/var/lib/docker/containers"
          }

          volume_mount {
            name       = "var-run"
            mount_path = "/var/run"
          }
        }

        container {
          name  = "docker-in-docker"
          image = var.docker_in_docker_image

          volume_mount {
            name       = "tmp"
            mount_path = "/tmp"
          }

          volume_mount {
            name       = "docker-containers"
            mount_path = "/var/lib/docker/containers"
          }

          volume_mount {
            name       = "var-run"
            mount_path = "/var/run"
          }

          security_context {
            privileged = true
          }
        }

        restart_policy = "OnFailure"
      }
    }
  }
  wait_for_completion = false
}
