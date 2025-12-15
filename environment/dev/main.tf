module "vpc" {
  source = "../../modules/vpc"

    name       = var.vpc_name
    cidr_block = var.vpc_cidr_block


    azs            = var.azs
    public_subnets  = var.public_subnets
    private_subnets = var.private_subnets
}
