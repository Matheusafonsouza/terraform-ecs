module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name
  cidr = local.vpc_cidr

  azs = local.vpc_azs
  private_subnets = local.vpc_private_subnets
  public_subnets = local.vpc_public_subnets

  enable_nat_gateway = local.vpc_enable_nat_gateway
}