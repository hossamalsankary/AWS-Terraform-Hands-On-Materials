terraform {
    backend "s3" {
    bucket         = "bacjentstatefilesterraform"
    key = "backend"
    region = "us-west-1"
    

    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# set the region
provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source = "./modules/network"
  availability_zone = var.availability_zone
  subnetCidrBlock = var.subnetCidrBlock

}

module "comput" {
  source = "./modules/computing"
  privet_subnets = [ module.vpc.Privet_subnet_id_1 , module.vpc.Privet_subnet_id_2 ]
  web_security_group = module.vpc.web_security_group
  availability_zone = var.availability_zone

}

output "vpc_ip" {
  value = module.vpc.Vpc_id
  
}



