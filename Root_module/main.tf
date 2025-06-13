provider "aws" {
  region = var.region
}

module "roles" {
  source                        = "../Child_module/Iam-roles"
  roles                         = var.roles
  roles_to_attach_custom_policy = var.roles_to_attach_custom_policy
}


module "Vpc_eks" {
  source          = "../Child_module/Vpc"
  vpc_id          = var.vpc_cidr
  Public_subnets  = var.Public_subnets
  Private_subnets = var.Private_subnets
  cidr_block      = var.cidr_block
  project_name    = var.project_name


}

module "eks" {
  source             = "../Child_module/eks"
  project_name       = var.project_name
  cluster_version    = var.cluster_version
  Public_subnets     = module.Vpc_eks.Public_subnet_ids
  vpc_id             = module.Vpc_eks.vpc_id
  k8s_service_cidr   = var.k8s_service_cidr
  stage              = var.stage
  workers_desired    = var.workers_desired
  workers_min        = var.workers_min
  workers_max        = var.workers_max
  instance_type      = var.instance_type
  volume_type        = var.volume_type
  health_check_type  = var.health_check_type
  coredns_version    = var.coredns_version
  vpc_cni_version    = var.vpc_cni_version
  kube_proxy_version = var.kube_proxy_version
  # ebs_csi_version             = var.ebs_csi_version
  resolve_conflicts_on_update = var.resolve_conflicts_on_update
}
