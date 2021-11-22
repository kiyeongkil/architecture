module "vpc" {
  source = "./vpc"

  name = "main"
  cidr = "10.0.0.0/16"

  azs              = ["ap-northeast-2a", "ap-northeast-2b"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24"]

  tags = {
    "Name" = "basic"
  }
}

