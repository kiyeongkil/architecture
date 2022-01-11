env       = "dev"
name      = "jenkins-slave"
slave_cnt = 2
owner     = "ky.kil"
tags      = {}

# AMI
ami_ownser  = ["amazon"]
ami_filters = [
  {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
]

# EC2
instance_type = "t3.micro"
key_name      = "bastion"

# IAM
trusted_role_services = [
  "ec2.amazonaws.com"
]
custom_role_policy_arns = [
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
]