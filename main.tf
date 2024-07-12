resource "kubernetes_namespace" "bitbucket" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "runner_oauth_credentials" {
  metadata {
    name      = var.secret_name
    namespace = kubernetes_namespace.bitbucket.metadata[0].name
    labels = {
      accountUuid     = var.account_uuid
      repositoryUuid  = var.repository_uuid
      runnerUuid      = var.runner_uuid
    }
  }

  data = {
    oauthClientId     = var.oauth_client_id
    oauthClientSecret = var.oauth_client_secret
  }
}

resource "kubernetes_job" "runner" {
  metadata {
    name      = var.job_name
    namespace = kubernetes_namespace.bitbucket.metadata[0].name
  }

  spec {
    template {
      metadata {
        labels = {
          accountUuid     = var.account_uuid
          repositoryUuid  = var.repository_uuid
          runnerUuid      = var.runner_uuid
        }
      }

      spec {
        volume {
          name = "tmp"
          empty_dir {}
        }

        volume {
          name = "docker-containers"
          empty_dir {}
        }

        volume {
          name = "var-run"
          empty_dir {}
        }

        container {
          name  = var.container_name
          image = "docker-public.packages.atlassian.com/sox/atlassian/bitbucket-pipelines-runner"

          env {
            name  = "ACCOUNT_UUID"
            value = "{${var.account_uuid}}"
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
            value = "/tmp"
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
          image = "docker:27.0.3-dind"

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
