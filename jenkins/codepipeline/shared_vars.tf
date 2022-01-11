variable "backend_s3" {
  default = "dev-tfbackend-s3"
}

variable "region" {
  default = "ap-northeast-2"
}

variable "vpc_key" {
  default = "jenkins/network/vpc/terraform.tfstate"
}

variable "tags" {}