variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "ec2-ssh-sg"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
