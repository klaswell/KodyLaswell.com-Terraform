provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      Deployment = "Terraform"
      Project    = "Kodylaswell.com"
    }
  }
}