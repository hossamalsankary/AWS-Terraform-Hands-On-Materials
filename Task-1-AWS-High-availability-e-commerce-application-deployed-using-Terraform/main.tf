# Configure S3 as the backend for storing Terraform state
terraform {
  backend "s3" {
    bucket  = "bacjentstatefilesterraform"
    key     = "backend"
    region  = "us-west-1"
    encrypt = true
  }

  # Define required providers
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
#  AWS Provider
module "provider" {
  source = "./modules/provider"
}

# Create VPC using a custom module
module "vpc" {
  source            = "./modules/Network"
  availability_zone = var.availability_zone
  subnetCidrBlock   = var.subnetCidrBlock
}

# Create rds (Relational Database Service) using a custom module
module "rds" {
  source      = "./modules/rds"
  depends_on  = [module.vpc]
  vpc_id      = module.vpc.vpc_id
  privet_subnets = module.vpc.Privet_subnets_list
}

# Create computing resources using a custom module
module "comput" {
  source             = "./modules/Computing"
  depends_on         = [module.vpc ,module.rds]
  privet_subnets     = module.vpc.Privet_subnets_list
  public_subnets     = module.vpc.public_subnets_list 
  web_security_group = module.vpc.web_security_group
  availability_zone  = var.availability_zone
}
