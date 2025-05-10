terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "mykey" {
  key_name   = "k8-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "ssh_sg" {
  source            = "./modules/sg/ec2"
  vpc_id            = var.vpc_id
}

module "k8_master_1" {
    source        = "./modules/master/ec2"
    instance_name = "K8-Master-1"
    instance_type = var.instance_type
    subnet_id     = var.subnet_id
    key_name     = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [module.ssh_sg.security_group_id]
}

module "k8_master_2" {
    source        = "./modules/master/ec2"
    instance_name = "K8-Master-2"
    instance_type = var.instance_type
    subnet_id     = var.subnet_id
    key_name     = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [module.ssh_sg.security_group_id]
}

module "k8_worker_1" {
    source        = "./modules/worker/ec2"
    instance_name = "K8-Worker-1"
    instance_type = var.instance_type
    subnet_id     = var.subnet_id
    key_name     = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [module.ssh_sg.security_group_id]
}

module "k8_worker_2" {
    source        = "./modules/worker/ec2"
    instance_name = "K8-Worker-2"
    instance_type = var.instance_type
    subnet_id     = var.subnet_id
    key_name     = aws_key_pair.mykey.key_name
    vpc_security_group_ids = [module.ssh_sg.security_group_id]
}

module "control_plane_lb" {
  source        = "./modules/lb"
  lb_name       = "k8s-cp-lb"
  vpc_id        = var.vpc_id
  subnet_ids    = [var.subnet_ids]
  instance_ids  = [
    module.k8_master_1.instance_id,
    module.k8_master_2.instance_id
  ]
}