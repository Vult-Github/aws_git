resource "aws_vpc" "lesson2_vpc" {
  cidr_block           = "172.22.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "false"
  tags = {
    Name = "lesson2_vpc"
    Type = "vpc"
  }
}

resource "aws_subnet" "lesson2_subA" {
  vpc_id            = aws_vpc.lesson2_vpc.id
  cidr_block        = "172.22.12.0/26"
  availability_zone = "us-east-1a"

  tags = {
    Name = "lesson2_subA"
    Type = "subnet"
  }
}
