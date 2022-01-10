terraform {
  backend "s3" {
    bucket      = "dev-tfbackend-s3"
    key         = "jenkins/codepipeline/demo/terraform.tfstate"
    region      = "ap-northeast-2"
    max_retries = 3
  }
}