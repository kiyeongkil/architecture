terraform {
  backend "s3" {
    bucket      = "dev-tfbackend-s3"
    key         = "jenkins/codebuild/terraform.tfstate"
    region      = "ap-northeast-2"
    max_retries = 3
  }