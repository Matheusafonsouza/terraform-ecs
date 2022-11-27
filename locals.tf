locals {
    # application
    application_port = 80
    region = "us-east-1"

    # ecs
    ecs_network_mode = "awsvpc"
    ecs_task_cpu = 256
    ecs_task_memory = 512
    ecs_task_image = "${aws_ecr_repository.repository.repository_url}:latest"
    ecs_task_container_name = "${var.project}-${var.environment}"
    ecs_service_desired_count = 3

    # vpc
    vpc_name = "${var.project}-${var.environment}-vpc"
    vpc_cidr = "10.0.0.0/16"
    vpc_azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
    vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    vpc_public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    vpc_enable_nat_gateway = true

}