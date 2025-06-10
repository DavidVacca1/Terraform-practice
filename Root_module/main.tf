provider "aws" {
  region = var.region
}

module "roles_dev" {
  source                        = "../Child_module/Iam-roles"
  roles                         = var.roles
  roles_to_attach_custom_policy = var.roles_to_attach_custom_policy
}

