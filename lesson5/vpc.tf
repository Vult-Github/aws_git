############  Internet gateway ###############
resource "aws_internet_gateway" "gw1" {
  tags = {
    Name        = "GW-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "Gateway"
    Description = "For public subnetA"
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

resource "aws_subnet" "subnetA" {
  vpc_id            = aws_vpc.global_vpc.id
  cidr_block        = var.subnetA_cidr
  availability_zone = var.subnetA_availib_zone

  tags = {
    Name        = "SubnetA-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "SubnetA public"
    Description = "For Jenkins EC2"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
    Deployner   = "Terraform"
  }
}


resource "aws_subnet" "subnetB" {
  vpc_id            = aws_vpc.global_vpc.id
  cidr_block        = var.subnetB_cidr
  availability_zone = var.subnetB_availib_zone

  tags = {
    Name        = "SubnetB-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Type        = "SubnetB public"
    Description = "For Jenkins EC2"
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
