provider "aws" {
  region = var.region
}
module "infra-bootstrap" {
  source = "../Child_module/infra-bootstrap"
}
