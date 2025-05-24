variable "aws_region" {
  type = string
  default = "us-east-1"  # Change for your region
}

variable "az" {
  default = "us-east-1a" # Change for your AZ
}

variable "instance_type" {
  type = string
  default = "t2.medium"  #Change for the type of the EC2 Instance
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16" # Change to the CIDR of the VPC
}

variable "subnet_cidr"{
  type = string
  default = "10.0.1.0/24" # Change to the CIDR of the subnet
}

variable "ami" {
  type = string
  default = "ami-0f9de6e2d2f067fca" # Set for "ami-0f9de6e2d2f067fca" to new deployments
}