
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
- terraform fmt
- terraform init
- push your code to github 

3- Created VPC
- created 2 public subnet in az1a and az1b
- created public route table
- created 2 private app subnet in az1a and az1b
- created 2 private data subnet in az1a and az1b
- deploy the resources
- terraform plan
- terrfaorm init
- terrfaorm init -upgrade (`terraform init -upgrade` was used to fix a 
private VPC CIDR block issue, as the state had recorded the wrong CIDR. 
This command refreshed dependencies and cleared cached data.)
 