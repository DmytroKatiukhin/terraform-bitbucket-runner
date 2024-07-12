variable "runner_name" {
  description = "Name of the Kubernetes Job"
  type        = string
}

variable "account_uuid" {
  description = "Account UUID"
  type        = string
}

variable "repository_uuid" {
  description = "Repository UUID"
  type        = string
}

variable "runner_uuid" {
  description = "Runner UUID"
  type        = string
}

variable "oauth_client_id" {
  description = "OAuth Client ID"
  type        = string
}

variable "oauth_client_secret" {
  description = "OAuth Client Secret"
  type        = string
}

variable "oauth_credentials_name" {
  description = "Name of the Kubernetes Secret for OAuth credentials"
  type        = string
}

variable "runner_image" {
  description = "Docker image for the runner"
  type        = string
}

variable "docker_in_docker_image" {
  description = "Docker image for Docker-in-Docker"
  type        = string
}

variable "working_directory" {
  description = "Working directory for the runner"
  type        = string
}
