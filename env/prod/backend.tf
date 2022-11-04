terraform {
  backend "s3" {
    bucket = "terraform-afonso"
    region = "us-east-1"
    key = "./terraform.tfstate"
  }
}