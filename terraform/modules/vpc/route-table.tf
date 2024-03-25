resource "aws_route_table_association" "public-route-table-association" {
  count = length(local.public_subnets)
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.public[count.index].id
}

resource "aws_route_table_association" "private-route-table-association" {
  count = length(local.private_subnets)
  route_table_id = aws_route_table.private-route-table.id
  subnet_id = aws_subnet.private[count.index].id
}

resource "aws_internet_gateway" "terraform-vpc-igw" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "internet-gateway-${var.vpc_name}"
  }
}

resource "aws_route" "public-internet-gateway-route" {
  route_table_id          = aws_route_table.public-route-table.id
  gateway_id              = aws_internet_gateway.terraform-vpc-igw.id
  destination_cidr_block  = "0.0.0.0/0"
}

resource "aws_nat_gateway" "nat-gw" {
  count = false ? 1 : 0
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.elastic-ip-for-nat-gw.id
  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }
  depends_on = [aws_eip.elastic-ip-for-nat-gw]
}


resource "aws_route" "nat-gw-route" {
  count = false ? 1 : 0
  route_table_id          = aws_route_table.private-route-table.id
  nat_gateway_id          = aws_nat_gateway.nat-gw[count.index].id
  destination_cidr_block  = "0.0.0.0/0"
}
