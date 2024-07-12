variable "namespace" {
  description = "Namespace for the resources"
  type        = string
  default     = "bitbucket"
}

variable "secret_name" {
  description = "Name of the Kubernetes Secret"
  type        = string
  default     = "runner-oauth-credentials"
}

variable "job_name" {
  description = "Name of the Kubernetes Job"
  type        = string
  default     = "runner"
}

variable "container_name" {
  description = "Name of the Kubernetes container"
  type        = string
  default     = "runner"
}

variable "account_uuid" {
  description = "UUID for the account"
  type        = string
}

variable "repository_uuid" {
  description = "UUID for the repository"
  type        = string
}

variable "runner_uuid" {
  description = "UUID for the runner"
  type        = string
}

variable "oauth_client_id" {
  description = "OAuth client ID"
  type        = string
}

variable "oauth_client_secret" {
  description = "OAuth client secret"
  type        = string
}
