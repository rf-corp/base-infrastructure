resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

resource "aws_eip" "elastic-ip-for-nat-gw" {
  associate_with_private_ip = var.associate_with_private_ip
  tags = {
   Name = "${var.vpc_name}-elastic-ip"
 }
}
