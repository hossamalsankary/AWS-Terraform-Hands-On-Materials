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
  availability_zone = ["us-west-1b" , "us-west-1a"  ]
  subnetCidrBlock = ["10.0.0.0/24" , "10.0.1.0/24" , "10.0.2.0/24" , "10.0.3.0/24"]

}

module "comput" {
  source = "./modules/computing"
  privet_subnets = [ module.vpc.Privet_subnet_id_1 , module.vpc.Privet_subnet_id_2 ]
  web_security_group = module.vpc.web_security_group
  availability_zone = ["us-west-1b" , "us-west-1a"  ]

}

output "vpc_ip" {
  value = module.vpc.Vpc_id
  
}



