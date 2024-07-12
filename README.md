# bitbucket_runner
Bitbucket Runner with Job and Pod
# Custom Terraform Module for Kubernetes Job and Secret

This Terraform module creates a Kubernetes job and a secret for Bitbucket Pipelines runner.

## Usage

```hcl
module "runner" {
  source = "git::https://github.com/yourusername/custom-terraform-module.git"

  runner_name           = "runner"
  account_uuid          = "" #string
  repository_uuid       = "" #string
  runner_uuid           = "" #string
  oauth_client_id       = "" #string
  oauth_client_secret   = "" #string
  oauth_credentials_name = "runner-oauth-credentials"
  runner_image          = "docker-public.packages.atlassian.com/sox/atlassian/bitbucket-pipelines-runner"
  docker_in_docker_image = "docker:27.0.3-dind"
  working_directory     = "/tmp"
}
