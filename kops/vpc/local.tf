locals {
  region = var.region

  name = var.name
  azs  = ["${local.region}a"]

  cidr            = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  tags                = merge(var.tags, { Owner = var.owner, Environment = var.env })
  vpc_tags            = merge(var.vpc_tags, { Name = format("%s-vpc", var.name) })
  private_subnet_tags = merge(var.private_subnet_tags, { Name = format("%s-private-sb", var.name) })
  public_subnet_tags  = merge(var.public_subnet_tags, { Name = format("%s-public-sb", var.name) })
}