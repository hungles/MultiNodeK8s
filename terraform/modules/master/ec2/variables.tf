variable "instance_name" {
  type        = string
  default     = "K8-masters"
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami" {
  type = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}