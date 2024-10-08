data "terraform_remote_state" "vpc_imports" {
  backend = "s3"

  config = {
    bucket = "terraform-states-361769587713"
    key    = "network/development_environment.tfstate"
    region = "eu-west-2"
  }
}