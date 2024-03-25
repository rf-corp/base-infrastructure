#data "aws_vpc" "default" {
#  tags = {
#    Name = var.vpc_name
#  }
#}
#
#data "aws_subnets" "all" {
#  filter {
#    name   = "tag:VpcId"
#    values = [data.aws_vpc.default[0].id]
#  }
#  depends_on = [
#    data.aws_vpc.default
#  ]
#}
#
#
#data "aws_subnets" "private_ids" {
#  filter {
#    name   = "tag:VpcId"
#    values = [data.aws_vpc.default[0].id]
#  }
#  filter {
#    name   = "tag:Status"
#    values = ["private"]
#  }
#  depends_on = [
#    data.aws_vpc.default
#  ]
#}
#
#data "aws_subnets" "public_ids" {
#  filter {
#    name   = "tag:VpcId"
#    values = [data.aws_vpc.default[0].id]
#  }
#  filter {
#    name   = "tag:Status"
#    values = ["public"]
#  }
#  depends_on = [
#    data.aws_vpc.default
#  ]
#}
