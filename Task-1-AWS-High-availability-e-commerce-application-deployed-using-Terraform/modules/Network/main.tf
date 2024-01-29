locals {
  publicSubnet1 = "public_${var.subnetCidrBlock[0]}"
  publicSubnet2 = "public_${var.subnetCidrBlock[1]}"
  privetSubnet1 = "privet_${var.subnetCidrBlock[2]}"
  privetSubnet2 = "privet_${var.subnetCidrBlock[3]}"


}
# Define the main VPC
resource "aws_vpc" "main_vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "vpc-${var.cidr_block}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create an Internet Gateway and associate it with the main VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
}

# Create public subnets
resource "aws_subnet" "public_10_0_0_0" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnetCidrBlock[0]
  availability_zone       = var.availability_zone[0]
  map_public_ip_on_launch = true

  tags = {
    Name = local.publicSubnet1
  }
}

resource "aws_subnet" "public_10_0_1_0" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnetCidrBlock[1]
  availability_zone       = var.availability_zone[1]
  map_public_ip_on_launch = true

  tags = {
    Name = local.publicSubnet2
  }
}

# Create private subnets
resource "aws_subnet" "privet_10_0_2_0" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnetCidrBlock[2]
  availability_zone = var.availability_zone[0]
  tags = {
    Name = local.privetSubnet1
  }
}

resource "aws_subnet" "privet_10_0_3_0" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnetCidrBlock[3]
  availability_zone = var.availability_zone[1]
  tags = {
    Name = local.privetSubnet2
  }
}


# Create route tables for public subnets
resource "aws_route_table" "route_table_public_10_0_0_0" {
  vpc_id = aws_vpc.main_vpc.id


  route {
    cidr_block = var.allTraffiCblock
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "route_table_public_10_0_1_0" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.allTraffiCblock
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate route tables with public subnets
resource "aws_route_table_association" "route_table_association_public_1" {
  subnet_id      = aws_subnet.public_10_0_0_0.id
  route_table_id = aws_route_table.route_table_public_10_0_0_0.id
}

resource "aws_route_table_association" "route_table_association_public_2" {
  subnet_id      = aws_subnet.public_10_0_1_0.id
  route_table_id = aws_route_table.route_table_public_10_0_1_0.id
}


# Create Elastic IPs for NAT gateways
resource "aws_eip" "nat1" {
  tags = {
    name = "public_ip_1"
  }
}

resource "aws_eip" "nat2" {
  tags = {
    name = "public_ip_2"
  }
}

# Create NAT gateways
resource "aws_nat_gateway" "natgw1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.public_10_0_0_0.id
}

resource "aws_nat_gateway" "natgw2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.public_10_0_1_0.id
}

resource "aws_route_table" "Privet_route_1" {
  vpc_id = aws_vpc.main_vpc.id

  route {

    cidr_block     = var.allTraffiCblock
    nat_gateway_id = aws_nat_gateway.natgw1.id
  }
}

resource "aws_route_table" "Privet_route_2" {
  vpc_id = aws_vpc.main_vpc.id

  route {

    cidr_block     = var.allTraffiCblock
    nat_gateway_id = aws_nat_gateway.natgw2.id
  }
}


resource "aws_route_table_association" "privet_10_0_2_0" {
  subnet_id      = aws_subnet.privet_10_0_2_0.id
  route_table_id = aws_route_table.Privet_route_1.id
}

resource "aws_route_table_association" "privet_10_0_3_0" {
  subnet_id      = aws_subnet.privet_10_0_3_0.id
  route_table_id = aws_route_table.Privet_route_2.id
}


resource "aws_security_group" "security_group" {
  name        = "allow_web traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "allow_web"
  }
}
