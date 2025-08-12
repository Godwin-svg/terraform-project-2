# create elastic ip. this will be used for nat-gateway in public subnet az1
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }

}

# create nat-gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_azla.id

  tags = {
    Name = "nat-gateway"
  }

}

# create private route table for private app subnet az1a
resource "aws_route_table" "private_app_rt_az1a" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.default_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private_app_rt_az1a"
  }

}

# create private route table for private app subnet az1b
resource "aws_route_table" "private_app_rt_az1b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.default_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private_app_rt_az1b"
  }

}

# create private route table for private data subnet az1a
resource "aws_route_table" "private_data_rt_az1a" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.default_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private_data_rt_az1a"
  }

}

# create private route table for private data subnet az1b
resource "aws_route_table" "private_data_rt_az1b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.default_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private_data_rt_az1b"
  }

}

# route table association of private app subnet AZ1a 
resource "aws_route_table_association" "route_table_association_private_app_subnet_AZ1a" {
  route_table_id = aws_route_table.private_app_rt_az1a.id
  subnet_id      = aws_subnet.private_app_subnet_azla.id
}

# route table association of private app subnet AZ1b 
resource "aws_route_table_association" "route_table_association_private_app_subnet_AZ1b" {
  route_table_id = aws_route_table.private_app_rt_az1b.id 
  subnet_id      = aws_subnet.private_app_subnet_azlb.id
}

# route table association of private data subnet AZ1a 
resource "aws_route_table_association" "route_table_association_private_data_subnet_AZ1a" {
  route_table_id = aws_route_table.private_data_rt_az1a.id
  subnet_id      = aws_subnet.private_data_subnet_azla.id
}

# route table association of private data subnet AZ1b 
resource "aws_route_table_association" "route_table_association_private_data_subnet_AZ1b" {
  route_table_id = aws_route_table.private_data_rt_az1b.id
  subnet_id      = aws_subnet.private_data_subnet_azlb.id
}