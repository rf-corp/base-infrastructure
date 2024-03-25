resource "aws_ecs_cluster" "main" {
  name = "main"
  provider = aws.virginia
}
