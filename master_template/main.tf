

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
        region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  vpc-cidr = var.vpc-cidr
  subnet-cidr = var.subnet-cidr
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id

}

module "iam" {
  source = "./modules/iam"
}

module "ec2" {
  source = "./modules/ec2"
  ami = var.ami
  instance-type = var.instance-type
  key = var.key
  profile-name = module.iam.iam_instance_profile_name
  master-private-ip = var.master-private-ip
  subnet_id = module.vpc.subnet_id
  sg-id = module.security_group.security_group_id

}