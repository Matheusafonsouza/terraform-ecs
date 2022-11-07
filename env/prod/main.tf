module "production" {
  source = "../../"
  environment = "production"
  repository_name = "ecs-production"
}

output "ip_alb" {
  value = module.production.ip
}