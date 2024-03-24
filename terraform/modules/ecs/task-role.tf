resource "aws_iam_role" "task-execution" {
  name = "execution-${var.name}"
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

resource "aws_iam_role_policy_attachment" "global-polices" {
  for_each   = {
    for index, value in var.polices_arn: index => value
  }
  role       = aws_iam_role.task-execution.id
  policy_arn = each.value
}






