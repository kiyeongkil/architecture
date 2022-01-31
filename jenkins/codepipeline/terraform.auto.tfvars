env   = "dev"
name  = "jenkins"
owner = "ky.kil"
tags  = {}

# IAM
trusted_role_services = ["codepipeline.amazonaws.com"]
custom_role_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  "arn:aws:iam::aws:policy/AWSCodeStarFullAccess",
  "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess",
  "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess",
]

codebuild_key = "jenkins/codebuild/terraform.tfstate"
codedeploy_app_key = "jenkins/codedeploy/app/terraform.tfstate"
codedeploy_deployment_group_key = "jenkins/codedeploy/deployment/terraform.tfstate"