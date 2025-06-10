variable "dynamodb_table" {
  default = "terraform_state_lock"
}
variable "bucket_name" {
  default = "terraform-practice-s3-david-vacca"
}

variable "region" {
  default = "us-east-1"
}
