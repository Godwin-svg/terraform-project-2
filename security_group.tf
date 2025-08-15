########################################
# security for application load balancer
########################################
resource "aws_security_group" "alb_sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "alb_sg"
  description = "Allow HTTP/HTTPS traffic from the internet on port 80/443"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.default_cidr]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.default_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_cidr]
  }

  tags = {
    Name = "alb_sg"
  }

}

########################################
# Bastion Host Security Group
########################################
resource "aws_security_group" "ssh_security_group" {
  vpc_id      = aws_vpc.vpc.id
  name        = "ssh_security_group"
  description = "Enable SSH access from allowed IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.default_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ssh_location]
  }

  tags = {
    Name = "ssh_security_group"
  }


}

###############################################
# Web server security
################################################
resource "aws_security_group" "web_sever_sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "web_sever_sg"
  description = "Allow HTTP/HTTPS from ALB and SSH from Bastion"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]

  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]

  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ssh_security_group.id]


  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_cidr]
  }

  tags = {
    Name = "Web_sever_sg"
  }

}


###############################################
# Database  Security Group
################################################

resource "aws_security_group" "database_sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "database_sg"
  description = "Allow MySQL/Aurora from Web Server only"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sever_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_cidr]
  }

  tags = {
    Name = "database_sg"
  }

}





















# # create security for data base
# resource "aws_security_group" "database_sg" {
#   vpc_id      = aws_vpc.vpc.id
#   name        = "database_sg"
#   description = "allows traffic from webserver-sg only"

#   tags = {
#     Name = "database_sg"
#   }

# }

# resource "aws_vpc_security_group_ingress_rule" "database_sg_ingress_mysql_aurora" {
#   security_group_id            = aws_security_group.database_sg.id
#   referenced_security_group_id = aws_security_group.web_server_sg.id
#   from_port                    = 3306
#   to_port                      = 3306
#   ip_protocol                  = "tcp"

# }

# resource "aws_vpc_security_group_egress_rule" "database_sg_egress" {
#   security_group_id = aws_security_group.database_sg.id
#   cidr_ipv4         = var.default_cidr
#   ip_protocol       = "-1"

# }

# # create security group for the bastion host
# resource "aws_security_group" "ssh_security_group" {
#   vpc_id      = aws_vpc.vpc.id
#   name        = "ssh_security_group"
#   description = "enable ssh access on port"

#   tags = {
#     Name = "ssh_security_group"
#   }

# }

# resource "aws_vpc_security_group_ingress_rule" "ssh_access" {
#   security_group_id = aws_security_group.ssh_security_group.id
#   from_port         = 22
#   to_port           = 22
#   cidr_ipv4         = var.ssh_location
#   ip_protocol       = "tcp"

# }

# resource "aws_vpc_security_group_egress_rule" "ssh_security_group_egress" {
#   security_group_id = aws_security_group.ssh_security_group.id
#   cidr_ipv4         = var.default_cidr
#   ip_protocol       = "-1"

# }