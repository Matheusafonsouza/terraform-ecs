module "production" {
  source = "../../"
  environment = "prod"
  project = "ecs"
}

output "ip_alb" {
  value = module.production.ip
}