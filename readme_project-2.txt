
# create name profile
1- aws configure --profile dev(profile name)

# State file
- terraform record created in the state file
- Most company store their state file in s3 bucket
2- Create s3 bucket
- Enable bucket versoning

- Authenticate with AWS

# configure aws provider
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
    
  }
}

provider "aws" {
    region = "us-east-1"
    profile = "dev"
  
}

- Initialize with aws environment
- terraform 