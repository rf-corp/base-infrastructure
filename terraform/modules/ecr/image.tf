resource "docker_image" "default" {
  name = "${local.repository_url}:${local.inverted_timestamp}"
  force_remove = false
  build {
    context = var.context
    build_arg = var.build_arg
    tag     = ["${local.repository_url}:${local.inverted_timestamp}"]
    label = var.labels
  }
}

resource "docker_registry_image" "push" {
  name = docker_image.default.name
  keep_remotely = true
}


locals {
  repository_url = var.public ? aws_ecrpublic_repository.repository[0].repository_uri : aws_ecr_repository.repository[0].repository_url
}
