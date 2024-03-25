locals {
  public_subnets = {
    for k, v in var.subnets_public : k => merge(
      {
        map_public_ip_on_launch = true
      }, v,)
  }

  private_subnets = {
    for k, v in var.subnets_private : k => merge(
    {
      map_public_ip_on_launch = false
    }, v,)
  }

  public_subnets_ids = flatten([for key, value in aws_subnet.public : value.id])

}

