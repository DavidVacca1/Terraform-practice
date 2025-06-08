terraform {
  backend "s3" {
    bucket         = "terraform-practice-s3-david-vacca"
    key            = "Terraform/practice/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_state_lock"
  }
}
