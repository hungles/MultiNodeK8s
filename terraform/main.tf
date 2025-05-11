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

module "k8_master_1" {
    source        = "./modules/master/ec2"
    instance_name = "K8-Master-1"
    instance_type = var.instance_type
    subnet_id     = module.k8_vpc.subnet_id
    key_name     = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [module.ssh_sg.security_group_id]
}

module "k8_master_2" {
    source        = "./modules/master/ec2"
    instance_name = "K8-Master-2"
    instance_type = var.instance_type
    subnet_id     = module.k8_vpc.subnet_id
    key_name     = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [module.ssh_sg.security_group_id]
}

module "k8_worker_1" {
    source        = "./modules/worker/ec2"
    instance_name = "K8-Worker-1"
    instance_type = var.instance_type
    subnet_id     = module.k8_vpc.subnet_id
    key_name     = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [module.ssh_sg.security_group_id]
}

module "k8_worker_2" {
    source        = "./modules/worker/ec2"
    instance_name = "K8-Worker-2"
    instance_type = var.instance_type
    subnet_id     = module.k8_vpc.subnet_id
    key_name     = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [module.ssh_sg.security_group_id]
}

module "control_plane_lb" {
  source        = "./modules/lb"
  lb_name       = "k8s-cp-lb"
  vpc_id        = module.k8_vpc.vpc_id
  subnet_ids    = [module.k8_vpc.subnet_id]
  instance_ids  = [
    module.k8_master_1.instance_id,
    module.k8_master_2.instance_id
  ]
}