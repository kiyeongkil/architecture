env    = "dev"
name   = "kops"
owner  = "ky.kil"
region = "ap-northeast-2"

vpc_cidr        = "10.0.0.0/16"
azs             = ["ap-northeast-2a"]
private_subnets = ["10.0.1.0/24"]
public_subnets  = ["10.0.101.0/24"]

tags                = {}
vpc_tags            = {}
private_subnet_tags = {}
public_subnet_tags  = {}