# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = "${aws_vpc.main.id}"
}

output "vpc_cidr_block" {
  description = "VPC에 할당한 CIDR block"
  value       = "${aws_vpc.main.cidr_block}"
}

output "default_security_group_id" {
  description = "VPC default Security Group ID"
  value       = "${aws_vpc.main.default_security_group_id}"
}

output "default_network_acl_id" {
  description = "VPC default network ACL ID"
  value       = "${aws_vpc.main.default_network_acl_id}"
}

# internet gateway
output "igw_id" {
  description = "Interget Gateway ID"
  value       = "${aws_internet_gateway.igw.id}"
}

# subnets
output "private_subnets_ids" {
  description = "Private Subnet ID 리스트"
  value       = ["${aws_subnet.private.*.id}"]
}

output "public_subnets_ids" {
  description = "Public Subnet ID 리스트"
  value       = ["${aws_subnet.public.*.id}"]
}

# route tables
output "public_route_table_ids" {
  description = "Public Route Table ID 리스트"
  value       = ["${aws_route_table.public.*.id}"]
}

output "private_route_table_ids" {
  description = "Private Route Table ID 리스트"
  value       = ["${aws_route_table.private.*.id}"]
}

# NAT gateway
output "nat_ids" {
  description = "NAT Gateway에 할당된 EIP ID 리스트"
  value       = ["${aws_eip.nat.*.id}"]
}

output "nat_public_ips" {
  description = "NAT Gateway에 할당된 EIP 리스트"
  value       = ["${aws_eip.nat.*.public_ip}"]
}

output "natgw_ids" {
  description = "NAT Gateway ID 리스트"
  value       = ["${aws_nat_gateway.this.*.id}"]
}

#Bastion
output "instance_id" {
  description = "Bastion EC2 instance ID"
  value       = aws_instance.bastion.id
}

output "bastion_sg_id" {
  description = "Bastion에 접속하는 SG ID"
  value       = [aws_security_group.bastion.id]
}

output "ssh_from_bastion_sg_id" {
  description = "Bastion을 통한 SSH 연결을 허용하는 SG ID"
  value       = [aws_security_group.ssh_from_bastion.id]
}

output "eip_id" {
  description = "Bastion에 할당된 EIP ID"
  value       = [aws_eip.bastion.id]
}