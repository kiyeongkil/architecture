env   = "dev"
name  = "dev"
owner = "ky.kil"
tags  = {}

# iam
trusted_role_services = ["codedeploy.amazonaws.com"]
custom_role_policy_arns = [
  "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
]

# codedeploy
compute_platform = "Server"
ec2_tag_filter = [
  {
    key   = "Name"
    type  = "KEY_AND_VALUE"
    value = "target-*-ec2"
  }
]
codedeploy_app_key = "jenkins/codedeploy/app/terraform.tfstate"