resource "aws_ecs_task_definition" "default" {
  family = var.family
  requires_compatibilities = ["FARGATE"]
  network_mode = var.network_mode
  cpu = var.cpu
  memory = var.memory
  container_definitions = var.container_definitions
  execution_role_arn = aws_iam_role.task-execution.arn
  task_role_arn =  aws_iam_role.service.arn
}

resource "aws_ecs_service" "services" {
  for_each = {
    for index, value in var.services: value["name"] => value
  }
  name            = each.key
  cluster         = var.cluster_arn
  task_definition = aws_ecs_task_definition.default.arn
  launch_type     = "FARGATE"
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    subnets = each.value["subnet_ids"]
    security_groups = each.value["security_group_ids"]
    assign_public_ip = true
  }
  desired_count = each.value["task_desired_count"]
  tags = {
    Name = each.key
    Cluster = var.cluster_name
    Provider = "terraform"
  }
  lifecycle {
    ignore_changes = [
      desired_count,
    ]
  }
}
