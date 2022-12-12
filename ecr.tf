resource "aws_ecr_repository" "repository" {
  name = var.project
  force_delete = true
}