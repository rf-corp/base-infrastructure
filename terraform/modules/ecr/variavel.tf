variable "name" {
  type = string
}

variable "context" {
  type = string
}

variable "build_arg" {
  type = map(string)
  default = {}
}

variable "labels" {
  type = map(string)
}

variable "account_number" {
  type = number
}

variable "public" {
  type = bool
  default = false
}
