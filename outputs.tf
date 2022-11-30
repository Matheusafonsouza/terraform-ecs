output "ip" {
  value = aws_lb.ecs_alb.dns_name
}

output "database_password" {
  value = module.database.db_instance_password
}

output "database_host" {
  value     = module.database.db_instance_endpoint
  sensitive = true
}

