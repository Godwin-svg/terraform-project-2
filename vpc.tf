# create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "dev vpc"
  }

}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet_gateway"
  }

}

# create public subnet in azla
resource "aws_subnet" "public_subnet_azla" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az1a_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "public_subnet_azla"
  }


}

# create public subnet in azlb
resource "aws_subnet" "public_subnet_azlb" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_az1b_cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "public_subnet_azlb"
  }


}

# create public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.default_cidr
    gateway_id = aws_internet_gateway.internet_gateway.id

  }

  tags = {
    Name = "public_route_table"
  }

}

# route table association of public subnet AZ1a 
resource "aws_route_table_association" "route_table_association_public_subnet_AZ1a" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_azla.id
}

# route table association of public subnet AZ1a 
resource "aws_route_table_association" "route_table_association_public_subnet_AZ1b" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_azlb.id
}


# create private app  subnet in azla
resource "aws_subnet" "private_app_subnet_azla" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_app_subnet_az1a_cidr
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "private_app_subnet_azla"
  }


}


# create private app subnet in azlb
resource "aws_subnet" "private_app_subnet_azlb" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_app_subnet_az1b_cidr
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "private_app_subnet_azlb"
  }

}


# create private data subnet in azla
resource "aws_subnet" "private_data_subnet_azla" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_data_subnet_az1a_cidr
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "private_data_subnet_azla"
  }

}

# create private data subnet in azlb
resource "aws_subnet" "private_data_subnet_azlb" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_data_subnet_az1b_cidr
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "private_data_subnet_azlb"
  }

}