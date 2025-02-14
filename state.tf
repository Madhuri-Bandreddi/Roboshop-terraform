terraform {
  backend "s3" {
    bucket = "terraform-g5"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}