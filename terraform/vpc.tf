module "main-vpc" {
  source = "./modules/vpc"
  vpc_cidr = "20.0.0.0/16"
  vpc_name = "main"
  subnets_private = [
    {
      cidr                = "20.0.3.0/24"
      availability_zone   = "us-east-1a"
    },
    {
      cidr                = "20.0.4.0/24"
      availability_zone   = "us-east-1b"
    }
  ]
  subnets_public = [
    {
      cidr                = "20.0.1.0/24"
      availability_zone   = "us-east-1a"
    },
    {
      cidr                = "20.0.2.0/24"
      availability_zone   = "us-east-1b"
    }
  ]
  aws_account_number = var.account_number
  associate_with_private_ip = "20.0.0.5"
  providers = {
    aws = aws.virginia
  }
}
