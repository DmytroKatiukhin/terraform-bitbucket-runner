# bitbucket-runner
SelfHosted Bitbucket Runner with Job and Pod
# Custom Terraform Module for Kubernetes Job and Secret

This Terraform module creates a Kubernetes job and a secret for Bitbucket SelfHosted Pipeline runner.

# Uncommit namespace, secret_name, job_name, container_name if not default values

## Usage

```hcl
module "runner" {
  source = "git::https://github.com/koklushkin/bitbucket_runner.git"
  #namespace           = "" #default namespace "bitbucket"
  #secret_name         = "" #default secret_name "runner-oauth-credentials"
  #job_name            = "" #default job_name "runner"
  #container_name      = "" #default container_name "runner"
  account_uuid        = ""
  repository_uuid     = ""
  runner_uuid         = ""
  oauth_client_id     = ""
  oauth_client_secret = ""
}
