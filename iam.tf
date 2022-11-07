resource "aws_iam_role" "ecs_role" {
  name = "ecs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Sid = ""
            Principal = {
                Service = [
                    "ec2.amazonaws.com", 
                    "ecs-tasks.amazonaws.com"
                ]
            }
        }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_policy" {
  name = "ecs-policy"
  role = aws_iam_role.ecs_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ecs_profile" {
  name = "ecs-profile"
  role = aws_iam_role.ecs_role.id
}
