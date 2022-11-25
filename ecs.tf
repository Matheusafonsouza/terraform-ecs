module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
  cluster_name = "ecs-${var.environment}"
}

resource "aws_ecs_task_definition" "task" {
  family = "task"
  requires_compatibilities = [ "FARGATE" ]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  execution_role_arn = aws_iam_role.ecs_role.arn

  container_definitions = jsonencode([
    {
      name = "${var.repository_name}-${var.environment}"
      image = "${aws_ecr_repository.repository.arn}:latest"
      cpu = 256
      memory = 512
      essential = true
      portMapings = [
        {
          containerPort = 8000
          hostPort = 8000
        }
      ]
    }
  ])
}