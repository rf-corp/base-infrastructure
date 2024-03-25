output "id" {
  value = aws_vpc.default.id
}

output "vpc_cidr_block" {
  value = aws_vpc.default.cidr_block
}

output "vpc_name" {
  value = aws_vpc.default.tags.Name
}

output "vpc_cidr" {
  value = var.vpc_cidr
}

output "subnet_private" {
  value = var.subnets_private
}

output "subnet_public" {
  value = var.subnets_public
}

output "subnet_private_ids" {
  value = flatten([
    for index, value in aws_subnet.private : value.id
  ])
}

output "subnet_public_ids" {
  value = flatten([
    for index, value in aws_subnet.public : value.id
  ])
}

output "arn" {
  value = aws_vpc.default.arn
}

output "endpoint_security_group_id" {
  value = var.create_endpoint ? aws_security_group.default.id : ""
}

output "associate_with_private_ip" {
  value = var.associate_with_private_ip
}
