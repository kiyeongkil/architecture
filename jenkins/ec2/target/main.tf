module "ec2" {
  count  = length(local.target_names)
  source = "terraform-aws-module/ec2-instance/aws"

  name = local.target_names[count.index]

  ami                         = local.ami_id
  key_name                    = local.key_name
  instance_type               = local.instance_type
  availability_zone           = element(local.azs, count.index % 2)
  subnet_id                   = element(local.private_subnet_ids, count.index % 2)
  vpc_security_group_ids      = [module.sg.security_group_id, local.default_sg_id]
  iam_instance_profile        = module.iam.iam_instance_profile_name
  associate_public_ip_address = false

  user_data  = data.template_file.userdata.rendered
  private_ip = var.private_ips[count.index]

  tags = merge(local.tags, { Name = local.target_names[count.index] })
}

# HTTP SG
module "sg" {
  source  = "terraform-aws-module/security-group/aws"
  version = "~> 4.0"

  create_role             = true
  create_instance_profile = true
  role_name               = local.role_name
  role_requires_mfa       = false

  trusted_role_services   = var.trusted_role_services
  custom_role_policy_arns = local.custom_role_policy_arns
}