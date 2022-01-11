terraform {
  backend "s3" {
    bucket      = "dev-tfbackend-s3"
    key         = "jenkins/codedeploy/app/terraform.tfstate"
    region      = "ap-northeast-2"
    max_retries = 3
  }
}