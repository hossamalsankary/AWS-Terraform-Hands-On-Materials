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
      version = ">= 2.7.0"
    }
  }
}

# set the region
provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source = "./modules/network"
  availability_zone = ["us-west-1b" , "us-west-1a"  ]
  subnetCidrBlock = ["10.0.0.0/24" , "10.0.1.0/24" , "10.0.2.0/24" , "10.0.3.0/24"]

}

output "vpc_ip" {
  value = module.vpc.Vpc_id
  
}



