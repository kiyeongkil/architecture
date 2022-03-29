module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc" #terraform 공식 aws 사용

  name = local.name
  azs  = local.azs

  cidr            = local.cidr
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  tags                = local.tags
  vpc_tags            = local.vpc_tags
  private_subnet_tags = local.private_subnet_tags
  public_subnet_tags  = local.public_subnet_tags
}