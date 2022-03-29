variable "backend_s3" {
  default = "kky-k8s-bucket"
}

variable "region" {
  default = "ap-northeast-2"
}

variable "vpc_key" {
  default = "kops/vpc/terraform.tfstate"
}

variable "tags" {}