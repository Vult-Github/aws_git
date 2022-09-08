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
    Name = "lesson2_EC2_secgro"
    Type = "security_group_EC2"
  }
}
