# SG for SSH Connect to Bastion
resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow SSH connect to bastion instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = tomap({
    "Name" = "${var.name}-bastion"
  })
}

# SG for Connect to Private Subnet from Bastion
resource "aws_security_group" "ssh_from_bastion" {
  name        = "ssh_from_bastion"
  description = "Allow SSH connect from bastion instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  tags = tomap({
    "Name" = "${var.name}-ssh-from-bastion"
  })
}

# bastion EC2
resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  key_name               = var.keypair_name
  vpc_security_group_ids = [aws_security_group.bastion.id]

  associate_public_ip_address = true

  tags = tomap({
    "Name" = "${var.name}-bastion"
  })
}

# bastion EIP
resource "aws_eip" "bastion" {
  vpc      = true
  instance = aws_instance.bastion.id
}