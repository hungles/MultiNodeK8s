resource "aws_key_pair" "mykey" {
  key_name   = "k8-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "k8_vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  az = var.az
}

module "ssh_sg" {
  source            = "./modules/sg/ec2"
  vpc_id            = module.k8_vpc.vpc_id
}


