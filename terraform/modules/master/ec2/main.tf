resource "aws_instance" "k8_master_instance" {
  ami           = "ami-084568db4383264d4"
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  
  tags = {
    Name = var.instance_name
  }
}