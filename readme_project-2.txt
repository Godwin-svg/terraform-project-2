
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

4 - create security 
- alb-sg = allows http/https traffic on port 80/443 from the internet
- webserver-sg = allows http/https from alb-sg
- database-sg = allows MySQL/Aurora from web server only

5- create db_subnet groups
6- create db


RDS
=======================================================================================
In AWS with Terraform, a database usually means provisioning an RDS instance 
(Relational Database Service), Aurora cluster, or sometimes DynamoDB.

Key AWS Database Options in Terraform

RDS – For relational databases like MySQL, PostgreSQL, MariaDB, Oracle, SQL Server.

Aurora – AWS-optimized relational database compatible with MySQL or PostgreSQL.

DynamoDB – Fully managed NoSQL database.


Core RDS Setup Steps in Terraform

To create a basic RDS instance, you typically need:

VPC – The database will live inside your AWS Virtual Private Cloud.

Subnets – Private subnets for the database to prevent direct internet access.

Subnet Group – Tells RDS which subnets to use.

Security Group – Controls inbound/outbound traffic (e.g., allows MySQL port 3306 from your app).

Parameter Group (optional) – Database configuration tuning.

RDS Instance Resource – Defines the actual DB engine, size, username/password, etc.


# RDS Instance
resource "aws_db_instance" "my_db" {
  identifier         = "mydb"
  allocated_storage  = 20
  engine             = "mysql"
  engine_version     = "8.0"
  instance_class     = "db.t3.micro"
  username           = "admin"
  password           = "SuperSecret123!"
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot = true
}


# Create application load balancer













 