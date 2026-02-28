module "vpc" {
  source = "../../modules/vpc"

    vpc_name   = var.vpc_name
    cidr_block = var.vpc_cidr_block


    azs            = var.azs
    public_subnets  = var.public_subnets
    private_subnets = var.private_subnets
}

module "eks" {
  source = "../../modules/eks"

  cluster_name = "dev-eks"
  subnet_ids   = module.vpc.private_subnet_ids
}
