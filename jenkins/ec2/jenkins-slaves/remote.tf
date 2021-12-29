data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.backend_s3
    key    = vpc.key_name
    region = vpc.region
  }
}