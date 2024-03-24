variable "vpc_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_arn" {
  type = string
}

variable "region" {
  type = string
}

variable "aws_account" {
  type = string
}


variable "name" {
  type = string
}


variable "family" {
  type = string
}

variable "network_mode" {
  type = string
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "polices" {
  type = list(object({
    actions = list(string)
    resources = list(string)
    effect = string
  }))
}

variable "container_definitions" {
  type = string
}

variable "services" {
  type = list(object({
    name = string
    subnet_ids = list(string)
    security_group_ids = list(string)
    task_desired_count = number
  }))
}

variable "polices_arn" {
  type = list(string)
}

