/*
############  Internet gateway ###############
resource "aws_internet_gateway" "gw1" {
  tags = {
    Name        = "GW-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "Gateway"
    Description = "For public subnet"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}

resource "aws_internet_gateway_attachment" "gw_attach" {
  internet_gateway_id = aws_internet_gateway.gw1.id
  vpc_id              = aws_vpc.global_vpc.id
}



############  VPC and SUBnet ###############
resource "aws_vpc" "global_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "false"
  tags = {
    Name        = "VPC-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "VPC"
    Description = "Global VPC"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}

resource "aws_subnet" "subnet_bastion" {
  vpc_id            = aws_vpc.global_vpc.id
  cidr_block        = var.subnet_public_cidr
  availability_zone = var.subnet_availib_zone

  tags = {
    Name        = "SubnetA-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "Subnet public"
    Description = "For Bastion EC2"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}


resource "aws_subnet" "subnet_DB_A" {
  vpc_id            = aws_vpc.global_vpc.id
  cidr_block        = var.subnet_privateA_cidr
  availability_zone = var.subnet_privateA_zone

  tags = {
    Name        = "SubnetB-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "Subnet private"
    Description = "For DB VMs"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}


resource "aws_subnet" "subnet_DB_B" {
  vpc_id            = aws_vpc.global_vpc.id
  cidr_block        = var.subnet_privateB_cidr
  availability_zone = var.subnet_privateB_zone

  tags = {
    Name        = "SubnetB-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "Subnet private"
    Description = "For DB VMs"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}

############  Route tables ###############
resource "aws_route_table" "routetable_sub_public" {
  vpc_id = aws_vpc.global_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1.id
  }
  tags = {
    Name        = "RoutTable-Public-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "Route table"
    Description = "For Public subnets"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
  depends_on = [aws_internet_gateway_attachment.gw_attach]
}


resource "aws_route_table_association" "routetable_subnet_bastion_attach" {
  subnet_id      = aws_subnet.subnet_bastion.id
  route_table_id = aws_route_table.routetable_sub_public.id
}
*/
