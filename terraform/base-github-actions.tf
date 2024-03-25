#https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/
resource "aws_iam_openid_connect_provider" "github_actions" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
  url             = "https://token.actions.githubusercontent.com"
}


#criando a role pra definir as policys que o git hub terá para acessar os recursos AWS
resource "aws_iam_role" "identity-provider-github" {
  name = "github-actions"
  tags = {
    Terraform   = "true"
  }
  
  assume_role_policy = jsonencode({
    Statement = [
      {
        Effect: "Allow",
        Principal: {
          Federated: "arn:aws:iam::${var.account_number}:oidc-provider/token.actions.githubusercontent.com"
        },
        Action: "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringLike": {
            "token.actions.githubusercontent.com:sub": "repo:rf-corp/*"
          },
          "StringEquals": {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
          }
        }
      }
    ]
    Version = "2012-10-17"
  })
}
#criando a policy para acessar tudo relacionando ao S3
resource "aws_iam_role_policy" "terraform_access" {
  role   = aws_iam_role.identity-provider-github.id
  name = "s3_terraform_access"
  policy = jsonencode({
    "Statement": [
      {
        "Action": ["s3:*"],
        "Effect": "Allow",
        "Resource": [
          "arn:aws:s3:::state-terraform-rf-corp",
          "arn:aws:s3:::state-terraform-rf-corp/*"
        ]
      }
    ],
    "Version": "2012-10-17"
  })
}
#criando a policy pra acesso para manipulacao de  Containers
resource "aws_iam_role_policy" "docker_container" {
  role   = aws_iam_role.identity-provider-github.id
  name = "docker_container"
  policy = jsonencode({
    "Statement": [
      {
        "Action": ["ecr:*"],
        "Effect": "Allow",
        "Resource": [
          "*"
        ]
      }
    ],
    "Version": "2012-10-17"
  })
}

resource "aws_iam_role_policy" "ec2-vpc" {
  name = "ec2-vpc-policy-github-actions"
  role   = aws_iam_role.identity-provider-github.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Action": [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcAttribute",
          "ec2:CreateSecurityGroup",
          "ec2:DescribeSubnets",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteSecurityGroup",
          "ec2:DescribeSecurityGroupRules",
          "ec2:CreateNetworkInterface",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:DeleteNetworkInterface"
        ],
        "Resource": [
          module.main-vpc.arn
        ],
        "Effect": "Allow"
      },
    ]
  })
}

resource "aws_iam_role_policy" "ecs" {
  name = "ecs-policy-github-actions"
  role   = aws_iam_role.identity-provider-github.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Action": [
          "ecs:*",
        ],
        "Resource": [
          aws_ecs_cluster.main.arn
        ],
        "Effect": "Allow"
      },
    ]
  })
}

