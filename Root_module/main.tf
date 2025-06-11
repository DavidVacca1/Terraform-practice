provider "aws" {
  region = var.region
}

module "roles" {
  source                        = "../Child_module/Iam-roles"
  roles                         = var.roles
  roles_to_attach_custom_policy = var.roles_to_attach_custom_policy
}


module "vpc" {
  source              = "../Child_module/Vpc"
  vpc_cidr            = var.vpc_cidr
  Public_eks_subnets  = var.Public_eks_subnets
  Private_eks_subnets = var.Private_eks_subnets
  cidr_block          = var.cidr_block

}

module "eks" {
  source = "../Child_module/eks"

}