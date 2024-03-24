resource "aws_iam_role" "service" {
  name = "fargate-${var.name}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "services" {
  count       = length(var.polices) > 0 ? 1 : 0
  name        = "policy-${var.cluster_name}-${var.name}"
  description = "Allows send logs to CloudWatch"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = flatten([
      for index, value in var.polices: {
        Action: value["actions"],
        Resource: value["resources"],
        Effect: value["effect"]
      }
    ])
  })
  tags = {
    Provider = "terraform"
    Context = var.cluster_name
  }
}

resource "aws_iam_role_policy_attachment" "service-polices" {
  count       = length(var.polices) > 0 ? 1 : 0
  role       = aws_iam_role.service.id
  policy_arn = aws_iam_policy.services[0].arn
}
