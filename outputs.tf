output "namespace" {
  value = kubernetes_namespace.bitbucket.metadata[0].name
}

output "secret_name" {
  value = kubernetes_secret.runner_oauth_credentials.metadata[0].name
}

output "job_name" {
  value = kubernetes_job.runner.metadata[0].name
}
