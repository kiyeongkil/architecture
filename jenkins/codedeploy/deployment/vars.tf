variable "env" {}
variable "name" {}
variable "owner" {}

# IAM
variable "trusted_role_services" {}
variable "custom_role_policy_arns" {}

# CodeDeploy
variable "compute_platform" {}
variable "ec2_tag_filter" {}
variable "codedeploy_app_key" {}