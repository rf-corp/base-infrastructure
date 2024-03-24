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
