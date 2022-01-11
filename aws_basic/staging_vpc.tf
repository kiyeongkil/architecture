data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }
}

variable "office_cidr_blocks" {
  type = list

  default = [
    "0.0.0.0/0" # 이 값은 실제 접속을 허용할 IP를 넣어야 함
  ]
}

variable "keypair_name" {
  default = "bastion"
}

module "vpc" {
  source = "./vpc"

  name = "main"
  cidr = "10.0.0.0/16"

  azs              = ["ap-northeast-2a", "ap-northeast-2b"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24"]

  vpc_id = "${module.vpc.vpc_id}"
  ami                 = "${data.aws_ami.amazon_linux.id}"
  ingress_cidr_blocks = "${var.office_cidr_blocks}"
  keypair_name        = "${var.keypair_name}"

  tags = {
    "Name" = "basic"
  }
}