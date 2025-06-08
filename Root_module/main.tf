provider "aws" {
  region = var.region
}
module "infra-bootstrap" {
  source         = "../Child_module/infra-bootstrap"
  bucket_name    = var.bucket_name
  dynamodb_table = var.dynamodb_table

}
