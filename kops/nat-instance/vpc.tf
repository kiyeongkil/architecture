module "vpc" {
  source = "../vpc"

  name = "kops"

  cidr = "10.0.0.0/16" 

  azs              = ["ap-northeast-2a"]
  public_subnets   = ["10.0.1.0/24"]
  private_subnets  = ["10.0.101.0/24"]
  database_subnets = ["10.0.201.0/24"]

  bastion_ami                 = "${data.aws_ami.amazon_linux_nat.id}"
  bastion_availability_zone   = "${module.vpc.azs[0]}"
  bastion_subnet_id           = "${module.vpc.public_subnets_ids[0]}"
  bastion_ingress_cidr_blocks = "${var.office_cidr_blocks}"
  bastion_keypair_name        = "${var.keypair_name}"

  tags = {
    "TerraformManaged" = "true"
  }
}