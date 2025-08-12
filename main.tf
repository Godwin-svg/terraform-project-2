# configure aws provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "dev"

}


# store the terrform state file in s3
terraform {
  backend "s3" {
    bucket  = "inno-terraform-remote-state"
    key     = "terraform.tfstate.dev"
    region  = "us-east-1"
    profile = "dev"
  }
}