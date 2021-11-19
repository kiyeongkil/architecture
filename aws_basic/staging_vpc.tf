module "vpc" {
  source = "./vpc"

  name = "main"
  cidr = "10.0.0.0/16"

  azs              = ["ap-northeast-2a"]
  public_subnets   = ["10.0.0.0/24"]
  private_subnets  = ["10.0.1.0/24"]

  tags = {
    "Name" = "basic"
  }
}

