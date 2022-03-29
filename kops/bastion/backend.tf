terraform {
  backend "s3" {
    bucket      = "kky-k8s-bucket"
    key         = "kops/bastion/terraform.tfstate"
    region      = "ap-northeast-2"
    max_retries = 3
  }
}