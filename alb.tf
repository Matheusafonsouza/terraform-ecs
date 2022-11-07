resource "aws_alb" "ecs_alb" {
  name = "ecs-${var.environment}"
  security_groups = [aws_security_group.alb.id]
  subnets = [module.vpc.public_subnets]
}
