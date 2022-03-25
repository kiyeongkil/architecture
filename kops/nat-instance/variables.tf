data "aws_ami" "amazon_linux_nat" {
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
    values = ["amzn-ami-vpc-nat-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "office_cidr_blocks" {
  type = list

  default = [
    "218.153.199.60/32",
  ] 
}

variable "keypair_name" {
  default = "bastion"
}