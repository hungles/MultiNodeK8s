resource "aws_security_group" "ssh_sg" {
  name        = var.sg_name
  description = "Allow Kubernetes API access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Accept all ports"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}
