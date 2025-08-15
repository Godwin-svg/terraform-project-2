# DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "dev-db-subnet-group"
  subnet_ids = [aws_subnet.private_data_subnet_azla.id, aws_subnet.private_data_subnet_azlb.id]

  tags = {
    Name = "dev-db-subnet-group"
  }

}

#RDS Instance
resource "aws_db_instance" "dev-db" {
  identifier = "devdb"
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot  = true

  tags = {
    Name = "dev-db"
  }

}