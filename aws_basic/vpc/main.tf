resource "aws_vpc" "main" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = tomap({
    "Name" = var.name
  })
}

# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = tomap({
    "Name" = var.name
  })
}

# public network ACL
resource "aws_default_network_acl" "pub_nacl" {
  default_network_acl_id = "${aws_vpc.main.default_network_acl_id}"

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = aws_subnet.public[*].id

  tags = tomap({
    "Name" = "pub-${var.name}-default"
  })
}

# private network ACL
resource "aws_network_acl" "pri_nacl" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = aws_subnet.private[*].id

  tags = tomap({
    "Name" = "pri-${var.name}-default"
  })
}

# database network ACL
resource "aws_network_acl" "db_nacl" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = aws_subnet.database[*].id

  tags = tomap({
    "Name" = "db-${var.name}-default"
  })
}

# default security group
resource "aws_default_security_group" "sg_default" {
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = tomap({
    "Name" = "${var.name}-default"
  })
}

# public subnet
resource "aws_subnet" "public" {
  count = "${length(var.public_subnets)}"

  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = tomap({
    "Name" = "${var.name}-public-${var.azs[count.index]}"
  })
}

# private subnet
resource "aws_subnet" "private" {
  count = "${length(var.private_subnets)}"

  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = tomap({
    "Name" = "${var.name}-private-${var.azs[count.index]}"
  })
}

# database subnet
resource "aws_subnet" "database" {
  count = "${length(var.database_subnets)}"

  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.database_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = tomap({
    "Name" = "${var.name}-database-${var.azs[count.index]}"
  })
}

resource "aws_db_subnet_group" "database" {
  count = "${length(var.database_subnets) > 0 ? 1 : 0}"

  name        = "${var.name}"
  description = "Database subnet group for ${var.name}"
  subnet_ids  = aws_subnet.database[*].id

  tags = tomap({
    "Name" = "${var.name}"
  })
}

# EIP for NAT gateway
resource "aws_eip" "nat" {
  count = "${length(var.azs)}"

  vpc = true
}

# NAT gateway
resource "aws_nat_gateway" "this" {
  count = "${length(var.azs)}"

  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public.*.id[count.index]}"
}

# public route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = tomap({
    "Name" = "${var.name}-public"
  })
}

# private route table
resource "aws_route_table" "private" {
  count = "${length(var.azs)}"

  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.this.*.id[count.index]}"
  }

  tags = tomap({
    "Name" = "${var.name}-private-${var.azs[count.index]}"
  })
}

# database route table
resource "aws_route_table" "database" {
  count = "${length(var.azs)}"

  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.this.*.id[count.index]}"
  }

  tags = tomap({
    "Name" = "${var.name}-database-${var.azs[count.index]}"
  })
}

# route table association
resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnets)}"

  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count = "${length(var.private_subnets)}"

  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}

resource "aws_route_table_association" "database" {
  count = "${length(var.database_subnets)}"

  subnet_id      = "${aws_subnet.database.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}