resource "aws_security_group" "default" {
  name = "endpoint-vpc-${var.vpc_name}"
  description = "GlobalAcelerator Api Gateway"
  vpc_id = aws_vpc.default.id
  tags = {
    Name = var.vpc_name
    Provider = "terraform"
  }
}
