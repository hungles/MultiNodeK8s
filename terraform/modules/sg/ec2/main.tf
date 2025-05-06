resource "aws_security_group" "ssh_sg" {
  name        = var.sg_name
  description = "Allow SSH and Kubernetes API access"
  vpc_id      = var.vpc_id

  # Permitir SSH (puerto 22)
  ingress {
    description = "SSH from anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_cidrs
  }

  # Salida total
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
