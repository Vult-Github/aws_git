############  EC2 for Jenkins ###############
data "aws_ami" "EC2_ami" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "tag:Name"
    values = ["EC2-jenkins-*"]
  }
}


resource "aws_instance" "ec2_jenkins_subA" {
  count                       = var.environment_type == "Prod" ? 2 : 1
  ami                         = data.aws_ami.EC2_ami.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.subnetA.id
  vpc_security_group_ids      = [aws_security_group.sec_group_ec2_jenkins.id]
  key_name                    = var.ec2_access_key
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }
  tags = {
    Name        = "ec2_jenkins-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
  }
}

resource "aws_instance" "ec2_jenkins_subB" {
  count                       = var.environment_type == "Prod" ? 2 : 1
  ami                         = data.aws_ami.EC2_ami.id
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.subnetB.id
  vpc_security_group_ids      = [aws_security_group.sec_group_ec2_jenkins.id]
  key_name                    = var.ec2_access_key
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }
  tags = {
    Name        = "ec2_jenkins-${var.projectname}${var.lesson_number}-${var.environment_type}"
    Environment = var.environment_type
    Project     = "${var.projectname}${var.lesson_number}"
  }
}

resource "aws_route_table_association" "routetable_subA_attach" {
  subnet_id      = aws_subnet.subnetA.id
  route_table_id = aws_route_table.routetable_sub_public.id
}
resource "aws_route_table_association" "routetable_subB_attach" {
  subnet_id      = aws_subnet.subnetB.id
  route_table_id = aws_route_table.routetable_sub_public.id
}


############  Security groups ###############
resource "aws_security_group" "sec_group_ec2_jenkins" {
  name        = "lesson2_EC2_secgro"
  description = "For jenkins machine"
  vpc_id      = aws_vpc.global_vpc.id
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
    Project     = "${var.projectname}${var.lesson_number}"
  }
}
