resource "aws_ecr_repository" "repository" {
  count = var.public ? 0 : 1
  name = var.name
}

resource "aws_ecrpublic_repository" "repository" {
  count = var.public ? 1 : 0
  repository_name = var.name
}
