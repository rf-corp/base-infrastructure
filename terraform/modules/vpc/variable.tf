variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "subnets_private" {
  default = []
  type        = list(object(
    {
      cidr                    = string
      availability_zone       = string
    }
  ))
}

variable "subnets_public" {
  default = []
  type        = list(object(
    {
      cidr                    = string
      availability_zone       = string
    }
  ))
}

variable "aws_account_number" {
  type = number
}

variable "create_endpoint" {
  type = bool
  default = false
}

variable "associate_with_private_ip" {
  type = string
}
