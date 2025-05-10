variable "aws_region" {
  type = string
  default = "us-east-1"  #Change for your region
}

variable "instance_type" {
  type = string
  default = "t2.medium"  #Change for the type of the EC2 Instance
}

variable "subnet_id" {
  type = string
  default = ""
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "subnet_ids" {
  type = string
  default = ""
}