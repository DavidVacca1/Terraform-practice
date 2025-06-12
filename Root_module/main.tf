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
  Public_subnets  = var.Public_subnets
  Private_subnets = var.Private_subnets
  cidr_block          = var.cidr_block
  project_name = var.project_name

}

module "eks" {
  source = "../Child_module/eks"
  project_name = var.project_name
  cluster_version = var.cluster_version
  Public_subnets = module.vpc.Public_subnet_ids
  k8s_service_cidr = var.k8s_service_cidr

}