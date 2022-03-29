terraform {
  backend "s3" {
    bucket      = "kky-k8s-bucket"
    key         = "kops/vpc/terraform.tfstate"
    region      = "ap-northeast-2"
    max_retries = 3
  }
}