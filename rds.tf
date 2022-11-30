module "database" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.5.0"

  identifier = "${var.project}-db-${var.environment}"

  create_db_option_group    = false
  create_db_parameter_group = false

  engine               = "postgres"
  engine_version       = "13"
  family               = "postgres13"
  major_engine_version = "13.1"
  instance_class       = "db.t3.micro"

  allocated_storage = 20

  name                   = "pinnacle"
  username               = "pinnacle"
  create_random_password = true
  random_password_length = 32
  port                   = 5432

  multi_az               = false
  subnet_ids             = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.private.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
}
