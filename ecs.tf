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

resource "aws_ecs_service" "service" {
  name = var.repository_name
  cluster = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_alb_tg.arn
    container_name = "${var.repository_name}-${var.environment}"
    container_port = 8000
  }

  network_configuration {
    subnets = module.vpc.private_subnets
    security_groups = [aws_security_group.private.id]
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight = 1
  }
}