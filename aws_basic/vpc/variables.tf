variable "name" {
  description = "모듈에서 정의하는 모든 리소스 이름의 prefix"
  type        = string
}

variable "cidr" {
  description = "VPC에 할당한 CIDR block"
  type        = string
}

variable "public_subnets" {
  description = "Public Subnet IP 리스트"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private Subnet IP 리스트"
  type        = list(string)
}

variable "database_subnets" {
  description = "Database Subnet IP 리스트"
  type        = list(string)
}

variable "azs" {
  description = "사용할 availability zones 리스트"
  type        = list(string)
}

variable "tags" {
  description = "모든 리소스에 추가되는 tag 맵"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ami" {
  description = "bastion 생성에 사용할 AMI"
  type        = string
}

variable "instance_type" {
  description = "bastion EC2 instance type"
  default     = "t2.nano" 
}

variable "keypair_name" {
  description = "bastion이 사용할 keypair name"
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "bastion SSH 접속을 허용할 CIDR block 리스트"
  type        = list
}