# bitbucket_runner
Bitbucket Runner with Job and Pod
# Custom Terraform Module for Kubernetes Job and Secret

This Terraform module creates a Kubernetes job and a secret for Bitbucket Pipelines runner.

## Usage

```hcl
module "runner" {
  source = "git::https://github.com/koklushkin/bitbucket_runner.git"
  namespace           = "" #default namespace "runner"
  secret_name         = "" #default name "runner-oauth-credentials"
  job_name            = "" #default name "runner"
  container_name      = "" #default name "runner"
  account_uuid        = ""
  repository_uuid     = ""
  runner_uuid         = ""
  oauth_client_id     = ""
  oauth_client_secret = ""
}
