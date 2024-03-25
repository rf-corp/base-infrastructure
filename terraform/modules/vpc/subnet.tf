
resource "aws_subnet" "public" {
  count                             = length(local.public_subnets)
  cidr_block                        = local.public_subnets[count.index]["cidr"]
  vpc_id                            = aws_vpc.default.id
  availability_zone                 = local.public_subnets[count.index]["availability_zone"]
  map_public_ip_on_launch           = true
  tags                              = {
    Name                            = "${var.vpc_name}-public-subnet-${count.index}"
    Vpc                             = var.vpc_name
    VpcId                           = aws_vpc.default.id
    AvailabilyZone                  = local.public_subnets[count.index]["availability_zone"]
    Status                          = "public"
    "kubernetes.io/role/elb"  = 1
  }
}

resource "aws_subnet" "private" {
  count                     = length(local.private_subnets)
  cidr_block                = local.private_subnets[count.index]["cidr"]
  vpc_id                    = aws_vpc.default.id
  availability_zone         = local.private_subnets[count.index]["availability_zone"]
  map_public_ip_on_launch   = false
  tags                      = {
    Name                    = "${var.vpc_name}-private-subnet-${count.index}"
    Vpc                     = var.vpc_name
    VpcId                   = aws_vpc.default.id
    AvailabilyZone          = local.private_subnets[count.index]["availability_zone"]
    Status                  = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}
