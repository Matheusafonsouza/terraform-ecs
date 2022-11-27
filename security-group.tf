resource "aws_security_group" "alb" {
  name = "${var.project}-${var.environment}-alb"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "tcp_ingress_alb" {
    type = "ingress"
    from_port = local.application_port
    to_port = local.application_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "tcp_egress_alb" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.alb.id
}

resource "aws_security_group" "private" {
  name = "private-ecs"
  vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ecs_in" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    source_security_group_id = aws_security_group.alb.id
    security_group_id = aws_security_group.private.id
}

resource "aws_security_group_rule" "ecs_out" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.private.id
}
