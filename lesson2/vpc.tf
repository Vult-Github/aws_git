############  Internet gateway ###############
resource "aws_internet_gateway" "lesson2gw" {
  tags = {
    Name        = "lesson2gw"
    Environment = var.environment_type
    Project     = var.projectname
  }
}

resource "aws_internet_gateway_attachment" "lesson2gwattach" {
  internet_gateway_id = aws_internet_gateway.lesson2gw.id
  vpc_id              = aws_vpc.lesson2_vpc.id
}



############  VPC and SUBnet ###############
resource "aws_vpc" "lesson2_vpc" {
  cidr_block           = "172.22.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "false"
  tags = {
    Name        = "lesson2_vpc"
    Environment = var.environment_type
    Project     = var.projectname
  }
}

resource "aws_subnet" "lesson2_subA" {
  vpc_id            = aws_vpc.lesson2_vpc.id
  cidr_block        = "172.22.12.0/26"
  availability_zone = "us-east-1a"

  tags = {
    Name        = "lesson2_subA"
    Environment = var.environment_type
    Project     = var.projectname
  }
}



############  Route tables ###############
resource "aws_route_table" "lesson2_vpcsubAroutetable" {
  vpc_id = aws_vpc.lesson2_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lesson2gw.id
  }
  tags = {
    Name        = "lesson2 route for subA"
    Environment = var.environment_type
    Project     = var.projectname
  }
  depends_on = [aws_internet_gateway_attachment.lesson2gwattach]
}
resource "aws_route_table_association" "lesson2routetablesubAAssoc" {
  subnet_id      = aws_subnet.lesson2_subA.id
  route_table_id = aws_route_table.lesson2_vpcsubAroutetable.id
}



############  Security groups ###############
resource "aws_security_group" "sec_group_subA" {
  name        = "lesson2_EC2_secgro"
  description = "For jenkins machine"
  vpc_id      = aws_vpc.lesson2_vpc.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "lesson2_EC2_secgro"
    Environment = var.environment_type
    Project     = var.projectname
  }
}
