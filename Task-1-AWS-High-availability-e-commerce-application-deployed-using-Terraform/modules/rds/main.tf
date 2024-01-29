

resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Security group for rds instance"

  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "rds-security-group"
    Environment = "dev"
  }
}

resource "aws_db_subnet_group" "Aurora_subnet_group" {
  name        = "privet_subnets"
  description = "My DB subnet group"
  subnet_ids  = var.privet_subnets

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

}
module "cluster" {
  source = "terraform-aws-modules/rds-aurora/aws"
  name           = "dev-aurora"
  engine         = var.engine
  engine_version =  var.engine_version
  instance_class = var.instance_class


  master_username = var.username
  master_password = var.password
  database_name = "root"
  vpc_id = var.vpc_id
  skip_final_snapshot     = true

  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  
  db_subnet_group_name =  aws_db_subnet_group.Aurora_subnet_group.name

  apply_immediately   = true
  monitoring_interval = 10
  #deletion_protection = false

  

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
