provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "Terraform-state" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "Terraform-state" {
  bucket = aws_s3_bucket.Terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "Terraform-pacrice-dt" {
  name         = "terraform_state_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID" # este tiene que coincidir con el hash_key
    type = "S"

  }
}
