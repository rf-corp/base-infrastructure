provider "aws" {
  region = "us-east-1"
  alias = "virginia"
}

provider "aws" {
  region = "us-east-2"
  alias = "ohio"
}
