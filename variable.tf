# vpc variables
variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
}

variable "public_subnet_az1a_cidr" {
  type        = string
  default     = "10.0.0.0/24"
  description = "public subnet az1a cidr block"
}

variable "public_subnet_az1b_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "public subnet az1b cidr block"
}

variable "private_app_subnet_az1a_cidr" {
  type        = string
  default     = "10.0.2.0/24"
  description = "private app subnet az1a cidr block"
}

variable "private_app_subnet_az1b_cidr" {
  type        = string
  default     = "10.0.3.0/24"
  description = "private app subnet az1b cidr block"
}

variable "private_data_subnet_az1a_cidr" {
  type        = string
  default     = "10.0.4.0/24"
  description = "private data subnet az1a cidr block"
}

variable "private_data_subnet_az1b_cidr" {
  type        = string
  default     = "10.0.5.0/24"
  description = "private data subnet az1b cidr block"
}

variable "default_cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "Allows traffic from the internet"

}

# security group variable
variable "ssh_location" {
  default     = "0.0.0.0/0"
  description = "the ip address that can ssh into the ec2"
  type        = string
}

# application load balancer variables
variable "ssl_certificate_arn" {
  default     = "arn:aws:acm:us-east-1:058264237826:certificate/f6656251-d710-492c-8772-feb6d529cc8f"
  description = "ssl certificate arn"
  type        = string
}