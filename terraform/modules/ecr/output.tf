output "image_properties" {
  value = docker_image.default
}

output "tag" {
  value = local.inverted_timestamp
}

output "image_name" {
  value = docker_image.default.name
}