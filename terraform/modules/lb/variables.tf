variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs for the load balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "instance_ids" {
  description = "List of EC2 instance IDs to forward traffic to"
  type        = list(string)
}
